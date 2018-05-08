#include <cstdlib>
#include <iostream>
#include <string>
#include <getopt.h>
#include <map>
#include <vector>

#include "hello.h"

static const std::string HELLO_WORLD = "Hello world!";

static const char* optString = "l:h?";

struct option longOpts[] = { { "level", 1, nullptr, 'l' },
                             { "help", 0, nullptr, 'h' },
                             { nullptr, 0, nullptr, 0 } };

std::map<std::string, std::vector<int>> g_Options;

void display_usage()
{
    std::cout << "Simple app demo with tests:" << std::endl;

    std::cout << "USAGE: ./myapp [-h] [-l log-level]" << std::endl;

    std::cout << "Option Arguments:\n"
            "        -h [ --help ]        Print this help messages\n"
            "        -l [ --log-level]    Choose log-level."
              << std::endl;
}

int main(int argc, char** argv)
{
    std::cout << HELLO_WORLD << std::endl;

    Hello hello;
    hello.printMessage();
    std::cout << hello.factorial(4) << std::endl;

    int longIndex;

    int opt = getopt_long(argc, argv, optString, longOpts, &longIndex);
    while (opt != -1)
    {
        switch (opt)
        {
            case 'h': /* fall-through is intentional */
            case '?': {
                display_usage();
                exit(EXIT_SUCCESS);
                break;
            }
            case 'l':
                g_Options[longOpts[longIndex].name].push_back(std::atoi(optarg));
                break;
            default:
                /* You won't actually get here. */
                break;
        }

        opt = getopt_long(argc, argv, optString, longOpts, &longIndex);
    }

    return EXIT_SUCCESS;
}