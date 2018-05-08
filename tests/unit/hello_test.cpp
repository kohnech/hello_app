#include <gtest/gtest.h> // googletest header file

#include <string>
using std::string;

const char *actualValTrue  = "hello gtest";
const char *actualValFalse = "hello world";
const char *expectVal      = "hello gtest";

TEST(HelloTest, CStrEqual) {
    EXPECT_STREQ(expectVal, actualValTrue);
}

TEST(HelloTest, CStrNotEqual) {
//    EXPECT_STREQ(expectVal, actualValFalse);
}

TEST(HelloTest, TwoPlusTwoEqualsFour)
{
    EXPECT_EQ(2 + 2, 4);
}