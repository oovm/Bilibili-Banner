(* ::Package:: *)

SetDirectory@ParentDirectory@NotebookDirectory[];


formatter[dict_] := Block[
	{name, img, logo},
	If[dict["c"] == {}, Return@Nothing];
	If[
		MissingQ@dict["c", "pic"],
		name = dict["c", "title"];
		img = dict["c", "background"];
		logo = dict["c", "logo"],
		name = dict["c", "name"];
		img = dict["c", "pic"];
		logo = dict["c", "litpic"]
	];
	Association[
		"CheckDate" -> ToExpression@First@StringSplit[dict["n"], {"_", "-"}],
		"Title" -> name,
		"Background" -> img,
		"Logo" -> logo
	]
];


json = Import["Scripts/banner.json", "RawJSON"];
data = DeleteDuplicatesBy[formatter /@ json, {#Background, #Logo}&];
Export["Banner.csv", Dataset[data /. Missing[___] :> ""]]
