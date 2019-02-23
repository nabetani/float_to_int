#include <algorithm>
#include <cmath>
#include <cstdint>
#include <functional>
#include <iostream>
#include <limits>
#include <string>
#include <unordered_map>
#include <vector>

using namespace std::literals;
using namespace std::string_literals;

bool is_integer(double x) { return std::floor(x) == x; }

bool is_integer_c(double x) { return std::ceil(x) == x; }

bool is_integer_r(double x) { return std::round(x) == x; }

bool is_integer_t(double x) { return std::trunc(x) == x; }

bool is_int_lround(double x) { return std::lround(x) == x; }

bool is_int32(double x) { return static_cast<std::int32_t>(x) == x; }

struct f_t {
  std::function<bool(double)> func;
  std::string name;
};

bool isint_floor(double x) {
  bool r = is_integer(x);
  if (r != is_integer_c(x) || r != is_integer_r(x) || r != is_integer_t(x)) {
    throw "unepxected";
  }
  return r;
}

std::vector<f_t> FUNCS{
    f_t{isint_floor, "floor"s},
    f_t{is_int_lround, "lround"s},
    f_t{is_int32, "int32_t"s},
};

struct kv_t {
  std::string name;
  double value;
};

std::vector<kv_t> KV{
    kv_t{"0.0", 0.0},
    kv_t{"1.0", 1.0},
    kv_t{"1.5", 1.5},
    kv_t{"1e18", 1e18},
    kv_t{"2e19", 2e19},
    kv_t{"9e19/7", 9e19 / 7},
    kv_t{"NAN", std::numeric_limits<double>::quiet_NaN()},
    kv_t{"INF", std::numeric_limits<double>::infinity()},
    kv_t{"-0.0", -0.0},
};

int main() {
  std::unordered_map<std::string, std::unordered_map<std::string, double>>
      results;
  for (auto const &f : FUNCS) {
    for (auto const &kv : KV) {
      auto r = f.func(kv.value);
      results[f.name][kv.name] = r;
    }
  }
  std::cout << "|入力|";
  for (auto const &f : FUNCS) {
    std::cout << f.name << "|";
  }
  std::cout << std::endl;
  std::cout << "|:--|";
  for (auto const &f : FUNCS) {
    std::cout << ":--:|";
  }
  std::cout << std::endl;
  for (auto const &kv : KV) {
    std::cout << "|" << kv.name << "|";
    for (auto const &f : FUNCS) {
      std::cout << (results[f.name][kv.name] ? "true" : "false" )<< "|";
    }
    std::cout << std::endl;
  }
  return 0;
}
