open Argu
open System
open System.IO

type Arguments =
    | [<AltCommandLine("-i")>] Input of input: string

    interface IArgParserTemplate with
        member s.Usage =
            match s with
            | Input _ -> "Specify the input file path."

[<EntryPoint>]
let main argv =
    let parser = ArgumentParser.Create<Arguments>(programName = "my-tool.exe")
    let results = parser.Parse argv

    let filePath = results.GetResult Input

    if File.Exists filePath then
        let content = File.ReadAllText filePath
        let splitContent = content.Split("\n\n", StringSplitOptions.RemoveEmptyEntries)

        let rangeStrings =
            splitContent.[0].Split('\n', StringSplitOptions.RemoveEmptyEntries)

        let ranges =
            rangeStrings
            |> Array.choose (fun (range: string) ->
                let parts = range.Split('-', StringSplitOptions.RemoveEmptyEntries)

                match parts with
                | [| minText; maxText |] ->
                    match Int64.TryParse minText, Int64.TryParse maxText with
                    | (true, minValue), (true, maxValue) -> Some(minValue, maxValue)
                    | _ ->
                        printfn "Error parsing range: %s" range
                        None
                | _ ->
                    printfn "Error parsing range: %s" range
                    None)
            |> Array.toList

        let ingredientIdStrings =
            splitContent.[1].Split('\n', StringSplitOptions.RemoveEmptyEntries)

        let ingredientIds =
            ingredientIdStrings
            |> Array.choose (fun (ingredientId: string) ->
                match Int64.TryParse ingredientId with
                | true, value -> Some value
                | _ ->
                    printfn "Error parsing ingredient id: %s" ingredientId
                    None)
            |> Array.toList

        let result = Part1.getResult ranges ingredientIds

        printfn "Result: %d" result
    else
        printfn "File not found: %s" filePath

    0
