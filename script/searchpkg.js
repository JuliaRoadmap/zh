const tagnames={
	data: ["数据"],
	draw: ["绘图","画图","图像"],
	format: ["格式"],
	gui: ["GUI","UI","图形用户界面"],
	lib: ["库"],
	"machine-learning": ["机器学习"],
	// meta: [],
	network: ["网络","爬虫"],
	plot: ["图像"],
	science: ["科学"],
	stdlib: ["标准库"],
	tool: ["工具","助手"],
	visualization: ["可视化"],
}
const tags={
	// ...: ["meta"],
	cairo: ["draw","visualization"],
	calculus: ["science"],
	colortypes: [],
	crc32c: ["tool"],
	CSV: ["data","format"],
	cubature: ["science"],
	dataframes: ["data","tool"],
	dataframesmeta: ["data","tool"],
	dates: ["stdlib"],
	downloads: ["network","stdlib"],
	gtk: ["gui"],
	leetcode: [""],
	lightlearn: [""],
	markdown: ["format","stdlib"],
	mljflux: ["machine-learning"],
	mljlinearmodels: ["tool"],
	pkg: ["stdlib","tool"],
	plots: ["data","plot","visualization"],
	query: ["data","tool"],
	random: ["data","stdlib"],
	sockets: ["network","stdlib"],
	toml: ["format","stdlib"],
	uuids: ["stdlib"],
	unicode: ["stdlib","tool"],
	zipfile: ["format"],
}
function searchpkg(str){
	let set=new Set()
	let result=[]
	// 提取标签
	for(let key in tagnames){
		let value= tagnames[key]
		value.concat(key)
		for(let name of value){
			if(str.includes(name)){
				set.add(key)
				break
			}
		}
	}
	// 遍历页面
	for(let key in tags){
		let tagset=new Set(tags[key])
		let flag=true
		for(let tag of set){
			if(!tagset.has(tag)){
				flag=false
				break
			}
		}
		if(flag){
			result=result.concat(key)
		}
	}
	return result
}
function searchinputchange(){
	let input=document.getElementById("search-input").value
	let vector=searchpkg(input)
	let html=""
	for(let i of vector){
		html+=`<li><a href=\"${i}.html\">${i}</a></li>`
	}
	document.getElementById("search-result-list").innerHTML=html
}
