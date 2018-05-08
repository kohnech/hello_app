# Makefile for gtest & pytest examples

## Project settings
export PROJ_ROOT := $(CURDIR)
OUTPUT = $(PROJ_ROOT)/output
TOOLS = $(PROJ_ROOT)/tools

## 3rd-party
## Repo/input & output
3RD_PARTY = $(OUTPUT)/3rd-party
GTEST_REPO = $(3RD_PARTY)/googletest
GTEST_SRCS = $(GTEST_REPO)/googletest

## Compiler C++
CXX = g++
CXXFLAGS = -Wall -std=c++11

## Compiler C
CCFLAGS = -Wall

## Linkage
LDFLAGS = pthread

## App
APP_EXECUTABLE = app
INC_DIR = -I$(PROJ_ROOT)/inc/
APP_SRC_DIR = $(PROJ_ROOT)/src
APP_SRCS = hello.cpp main.cpp rectangle.cpp
APP_LIB = $(filter-out main.cpp, $(APP_SRCS))
APP_LIB_SRCS = $(addprefix $(APP_SRC_DIR)/,$(APP_LIB))
OBJS = $(patsubst %.cpp,$(OUTPUT)/%.o,$(APP_SRCS))

## Unit tests
UNIT_TEST_DIR = $(PROJ_ROOT)/tests/unit
TEST_SRCS = $(UNIT_TEST_DIR)/hello_test.cpp $(UNIT_TEST_DIR)/main.cpp
TEST_TARGET = hello_test

## Component tests
COMPONENT_TEST_DIR = $(PROJ_ROOT)/tests/component

## Python
PYTHON_VERSION ?= 3

.PHONY: help all debug clean clean_all install $(OUTPUT) test app env unit_tests component_tests

help:
	@echo
	@echo '  all                   - build and create all targets currently: tests and app.'
	@echo '  app                   - build the app.'
	@echo '  install               - clones gtest/gmock repo from github and installs it.'
	@echo '  test                  - run all tests targets currently: unit & component'
	@echo '  unit_tests            - run unit tests'
	@echo '  component_tests       - run component tests'
	@echo '  clean                 - clean compiled units.'
	@echo '  clean_all             - deletes output folder and installations.'
	@echo

all: app test

test: unit_tests component_tests

debug: CXXFLAGS += -DDEBUG -g
debug: CCFLAGS += -DDEBUG -g
debug: app

app: $(OUTPUT) $(OBJS)
	$(info Runing app target)
	$(CXX) -o $(APP_EXECUTABLE) $(OBJS) -L$(OUTPUT)

$(OUTPUT):
	$(info Create output folder)
	mkdir -p $@

$(OBJS): $(OUTPUT)/%.o : $(APP_SRC_DIR)/%.cpp
	$(info Compiling...)
	@echo [Compile] $<
	@$(CXX) $(INC_DIR) -c $(CXXFLAGS) $< -o $@

$(TEST_TARGET): $(OUTPUT)/libgtest.a
	$(info Runing test target)
	$(CXX) $(INC_DIR) -isystem ${GTEST_SRCS}/include -pthread $(CXXFLAGS) $(TEST_SRCS) $(APP_LIB_SRCS) $(OUTPUT)/libgtest.a -o $@

$(OUTPUT)/libgtest.a: install
	$(info Runing libgtest.a target)
	cd $(OUTPUT)
	$(CXX) -isystem ${GTEST_SRCS}/include -I${GTEST_SRCS} \
	-pthread -c ${GTEST_SRCS}/src/gtest-all.cc -o $(OUTPUT)/gtest-all.o
	ar -rv $(OUTPUT)/libgtest.a $(OUTPUT)/gtest-all.o

install: $(OUTPUT)
	$(info Cloning repo...)
	$(TOOLS)/clone.sh git@github.com:google/googletest.git $(GTEST_REPO) false

unit_tests: $(TEST_TARGET)
	./$(TEST_TARGET)

venv_package := $(shell command -v virtualenv 2> /dev/null)

venv:
ifndef venv_package
	$(error "virtualenv is not available please install sudo apt-get install python-virtualenv")
endif
	virtualenv -p python$(PYTHON_VERSION) $@
	./venv/bin/pip install -r $(COMPONENT_TEST_DIR)/requirements.txt

component_tests: venv app
	@echo "[Running component tests..]"
	./venv/bin/pytest $(COMPONENT_TEST_DIR)

clean:
	$(info Cleaning...)
	rm -f $(TEST_TARGET) $(OBJS) app
	rm -f $(OUTPUT)/libgtest.a $(OUTPUT)/gtest-all.o

clean_all: clean
	rm -rf $(3RD_PARTY)
	rm -rf $(OUTPUT)
	rm -rf venv

