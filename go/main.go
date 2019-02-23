package main

import (
	"fmt"
	"math"
)

func isInteger(x float64) bool {
	return math.Floor(x) == x
}

func isIntegerModf(x float64) bool {
	_, frac := math.Modf(x)
	return frac == 0
}

func isInt32(x float64) bool {
	return float64(int32(x)) == x
}

type ftType struct {
	name string
	f    func(float64) bool
}

var fts = []ftType{
	ftType{name: "floor", f: isInteger},
	ftType{name: "modf", f: isIntegerModf},
	ftType{name: "int32", f: isInt32},
}

type inType struct {
	name string
	v    float64
}

var inputs = []inType{
	inType{name: "0.0", v: 0.0},
	inType{name: "1.0", v: 1.0},
	inType{name: "1.5", v: 1.5},
	inType{name: "1e18", v: 1e18},
	inType{name: "2e19", v: 2e19},
	inType{name: "NAN", v: math.NaN()},
	inType{name: "INF", v: math.Inf(1)},
	inType{name: "-0.0", v: -0.0},
	inType{name: "2147483648", v: 2147483648},
	inType{name: "2147483647", v: 2147483647},
	inType{name: "-2147483649", v: -2147483649},
	inType{name: "-2147483648", v: -2147483648},
}

func main() {
	r := map[string]map[string]bool{}
	for _, f := range fts {
		r[f.name] = map[string]bool{}
		for _, i := range inputs {
			r[f.name][i.name] = f.f(i.v)
		}
	}
	fmt.Print("|入力|")
	for _, f := range fts {
		fmt.Printf("%s|", f.name)
	}
	fmt.Println()
	fmt.Print("|:--|")
	for range fts {
		fmt.Print(":--:|")
	}
	fmt.Println()
	for _, i := range inputs {
		fmt.Print("|" + i.name + "|")
		for _, f := range fts {
			fmt.Printf("%v|", r[f.name][i.name])
		}
		fmt.Println()
	}
}
