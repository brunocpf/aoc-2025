module Part2

let getResult ranges =
    ranges
    |> List.sortBy fst
    |> Seq.fold
        (fun (accMaxOpt, accTotal) (currentMin, currentMax) ->
            match accMaxOpt with
            | None -> Some currentMax, accTotal + currentMax - currentMin + 1L
            | Some accMax ->
                let start = max currentMin (accMax + 1L)
                let add = max 0L (currentMax - start + 1L)
                Some(max accMax currentMax), accTotal + add)
        (None, 0L)
    |> snd
