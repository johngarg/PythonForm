Package["PythonForm`"]

(* MIT License

Copyright (c) 2022 John Gargalionis

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. *)

Print["Main package PythonForm.m loaded!"];

$Kwargs = "kwargs";
$Numpy = "np.";
$L = "(";
$R = ")";

PythonForm[x_String] := "'" <> x <> "'";
PythonForm[x_Integer] := ToString[x];
PythonForm[x_Association] :=
  "{" <>
      Table[
        PythonForm[ToString[i[[1]]]] <> ":" <> PythonForm[i[[2]]] <> ","
      , {i, Normal[x]}
      ] <> "}";
PythonForm[Rational[a_, b_]] := PythonForm[a] <> "/" <> PythonForm[b];
PythonForm[Times[a_, b_]] := PythonForm[a] <> " * " <> PythonForm[b];
PythonForm[Plus[a_, b__]] := $L <> StringRiffle[Map[PythonForm, List[a, b]], " + "] <> $R;
PythonForm[Power[a_, b_]] := $L <> PythonForm[a] <> $R <> "**" <> $L <> PythonForm[b] <> $R;
PythonForm[Log[x__]] := $Numpy <> "log" <> $L <> PythonForm[x] <> $R;
PythonForm[\[Pi]] := $Numpy <> "pi";
PythonForm[y_[i_,j_]] := PythonForm[y] <> "[" <> PythonForm[i] <> "," <> PythonForm[j] <> "]";
PythonForm[x_] /; Head[x] === Symbol := $Kwargs <> "[" <> PythonForm[ToString[x]] <> "]";

PackageExport["PythonForm"]
