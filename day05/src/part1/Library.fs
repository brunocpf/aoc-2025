module Part1

let private inRange (min, max) value = value >= min && value <= max

let private inRanges ranges value =
    List.exists (fun range -> inRange range value) ranges

let getResult ranges ingredientIds =
    ingredientIds |> List.filter (inRanges ranges) |> List.length
