const express=require('express');

const port=8080
const app=express();

app.get('/',(req,res)=>{
    res.send('Hello!! this is running...')
})

app.listen(port,()=>{
    console.log(`App listening at port:${port}`)
})