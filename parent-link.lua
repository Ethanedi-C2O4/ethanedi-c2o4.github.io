local function normalize(path)
  return path:gsub("\\", "/"):gsub("/+$", "")
end

function Pandoc(doc)
  local input = normalize(quarto.doc.input_file)
  local root = normalize(quarto.project.directory)

  -- トップページには親階層リンクを付けない
  if input == root .. "/index.qmd" then
    return doc
  end

  local parent_link = pandoc.Para({
    pandoc.Link(
      {
        pandoc.Str(""),
        pandoc.Space(),
        pandoc.Str("上の階層へ")
      },
      "../"
    )
  })

  doc.blocks:insert(1, parent_link)
  return doc
end
