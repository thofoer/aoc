import * as fs from 'fs';

const input = fs.readFileSync('input2.txt','utf8');
const sums = input.split('\r\n\r\n').map( l => l.split('\r\n').map(z=>+z).reduce((a,c)=>a+c))

console.dir(sums.sort((x,y)=>y-x))

console.log(Math.max(...sums))
