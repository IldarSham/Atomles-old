const express = require('express')
const levenshtein = require('fast-levenshtein')

const characters = require('./data/characters.json')
const characters_detail = require('./data/characters_detail.json')

const app = express()
const port = 3000

app.use('/images', express.static(`${__dirname}/images`))

app.get('/characters/main', (req, res) => {
  const mainCharacters = characters.slice(0, 3)
  res.json(mainCharacters)
})

app.get('/characters/search', (req, res) => {
  const name = req.query.name

  let results = []
  let minDistance = 2

  for (const character of characters) {
    const distance = levenshtein.get(name, character.name)

    if (distance < minDistance) {
      minDistance = distance
      results.unshift(character)
    }
  }

  res.json(results)
})

app.get('/characters/detail', (req, res) => {
  const id = req.query.id

  const character = characters_detail.find(character => character.id == id)
  res.json(character)
})

app.listen(port, () => {
  console.log(`AtomlesApp listening at http://localhost:${port}`)
})