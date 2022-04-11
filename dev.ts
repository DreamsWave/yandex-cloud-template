import express from 'express'
import path from 'path'
import fs from 'fs'

const LOCAL_URL = "http://localhost"
const PORT = 3000
const app = express()
const router = express.Router()
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/', router)

app.all('/', async (req, res) => {
    console.log(req)
    return res.send('ok')
})

fs.readdir(path.join(path.resolve(), 'functions'), async (err, functions) => {
    for (let func of functions) {
        const funcUrl = `${LOCAL_URL}:${PORT}/${func}`
        console.log(funcUrl)
        const handler = await import(path.join(path.resolve(), 'functions', func, 'src', 'index.ts'))
        router.all(`/${func}/`, async (req, res) => {
            console.log(req.method, funcUrl)
            const event = { ...req.body, body: JSON.stringify(req.body.body) }
            res.send(await handler.handler(event))
        })
    }
});

app.listen(PORT, () => {
    console.log(`Server started`)
})