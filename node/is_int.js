"use strict";

function is_integer(x) {
  return x == Math.floor(x);
}

function is_int_bitor(x) {
  return x == (x|0);
}

function is_uint32_typedarray(x) {
  return (new Uint32Array([x]))[0]==x;
}

function is_uint32_compare(x) {
  return is_integer(x) && 0<=x && x<=4294967295;
}

const funcs = [
  { name: "floor", func: is_integer },
  { name: "bit or", func: is_int_bitor },
  { name: "Uint32Array", func: is_uint32_typedarray },
  { name: "uint32(比較)", func: is_uint32_compare },
];

const inputs = [
  { name: "0.0", value: 0.0 },
  { name: "1.0", value: 1.0 },
  { name: "1.5", value: 1.5 },
  { name: "1e18", value: 1e18 },
  { name: "2e19", value: 2e19 },
  { name: "NAN", value: NaN },
  { name: "INF", value: Infinity },
  { name: "-0.0", value: -0.0 },
  { name: "2147483648", value:2147483648 },
  { name: "2147483647", value:2147483647 },
  { name: "-2147483649", value:-2147483649 },
  { name: "-2147483648", value:-2147483648 },
];

let results = {};

funcs.forEach(func => {
  results[func.name] = {};
  inputs.forEach(input => {
    results[func.name][input.name] = func.func(input.value);
  });
});


console.log( "|入力|"+funcs.map( e=>{
  return e.name+"|";
}).join("") );

console.log( "|:--|"+funcs.map( ()=>{
  return ":--:|";
}).join("") );

inputs.forEach( i=>{
  console.log( "|"+i.name+"|"+funcs.map(f=>{
    return results[f.name][i.name] ? "true|" : "false|";
   }).join("") );
});