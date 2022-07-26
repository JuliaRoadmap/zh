var tURL=document.getElementById("tURL").content
var theme=localStorage.getItem("theme")
if(theme==undefined)theme="light"
else if(theme!="light")document.getElementById("theme-href").href=`${tURL}${tar_css}/${theme}.css`
const oril=document.location.origin.length
requirejs.config({ paths: configpaths, shim: configshim})
require(main_requirement, function($){
	$(document).ready(function(){

let settings=document.createElement("div")
settings.className="modal"
settings.id="documenter-settings"
settings.innerHTML=`
<div class="modal-background"></div>
<div class="modal-card">
	<header class="modal-card-head"><p class="modal-card-title">⚙</p><button class="delete"></button></header>
	<section class="modal-card-body">
		<div class="select"><select id="documenter-themepicker"><option value="light">light</option><option value="dark">dark</option></select></div>
	</section>
	<footer class="modal-card-foot"></footer>
</div>`
document.body.append(settings)
$("#documenter-settings-button").click(() => settings.classList.toggle("is-active"))
$("#documenter-settings button.delete").click(() => settings.classList.remove("is-active"))
$(document).keyup((e) => {if(e.keyCode==27)settings.classList.remove("is-active")})
var sidebar = $("#documenter > .docs-sidebar")
var sidebar_button = $("#documenter-sidebar-button")
sidebar_button.click(function(ev){
	ev.preventDefault()
	sidebar.toggleClass('visible')
	if(sidebar.hasClass('visible'))$("#documenter .docs-menu a.is-active").focus()
})
$("#documenter > .docs-main").bind('click', function(ev){
	if($(ev.target).is(sidebar_button))return
	if(sidebar.hasClass('visible'))sidebar.removeClass('visible')
})
let e=$("#documenter .docs-autofit")
function resize(){
	let L=parseInt(e.css('max-width'))
	let L0=e.width()
	if(L0>L){
		let h0=parseInt(e.css('font-size'))
		e.css('font-size', L*h0/L0)
	}
}
resize()
$(window).resize(resize)
$(window).on('orientationchange', resize)
let pi=$("#documenter-themepicker")
for(let tag of pi[0].children){
	if(tag.value==theme){
		tag.selected=true; break
	}
}
pi.change(function(){
	var theme=pi[0].value
	$("#theme-href")[0].href=`${tURL}${tar_css}/${theme}.css`
	localStorage.setItem("theme", theme)
})
$(".content .docs-heading-anchor-permalink").click(function(ev){
	let s=document.location.href
	let id=ev.target.parentNode.id
	navigator.clipboard.writeText(s+"#"+id).then(
		() => {}, () => window.alert("failed")
	)
})
let hljs=window.hljs
hljs.registerAliases("plain", {languageName: "plaintext"})
hljs.registerAliases("jl", {languageName: "julia"})
hljs.highlightAll()
for(let i of $("code.hljs")){
	hljs.lineNumbersBlock(i, {singleLine: true})
	let header=i.parentElement.parentElement.firstElementChild
	header.innerHTML=`<span class='codeblock-paste' onclick='copycodeblock(event)'>📋</span>`
}
buildmenu()
for(let i of $(".checkis")){
	var chk=i.dataset["check"]
	if(localStorage.getItem(chk)=="true"){
		i.style.display="block"
	}
}
$(".submit-fill").click(function(ev){
	submit_fill(ev.target)
})
$(".ans-fill").click(function(ev){
	let i=ev.target
	i.parentNode.children[1].value=i.dataset["ans"]
})
$(".instruction-fill").click(function(ev){
	let i=ev.target
	i.parentNode.children[1].value=i.dataset["con"]
})
let marked=JSON.parse(localStorage.getItem("marked"))
marked = marked==null ? (new Set()) : (new Set(marked))
for(let it of $(".li-dir,.li-file")){
	let span=document.createElement("span")
	span.onclick=function(){
		span.classList.toggle("li-marked")
		toggle_mark(it)
	}
	if(marked.has(it.firstElementChild.href.substring(oril)))span.className="li-marked"
	it.prepend(span)
}
$(".hljs-ln-numbers").ready(function(){
	let loc=document.location.hash
	loc=loc.substring(1, loc.length)
	if(loc[0]=='L'){
		let split=loc.search('-')
		let from=Number(loc.substring(1, split))
		let to=Number(loc.substring(split+2, loc.length))
		scroll_to_lines(from, to)
	}
})
$('.modal-card-foot').innerText=buildmessage
const clockemojis="🕛🕐🕑🕒🕓🕔🕕🕖🕗🕘🕙🕚⌛ "
for(let i of $(".test-area")){
	let header=document.createElement("div")
	header.className="test-header"
	let name=document.createElement("code")
	name.innerText=i.dataset["name"]
	let fullscore=document.createElement("span")
	fullscore.className="tag"
	fullscore.innerText=" ?/"+i.dataset["fs"]+" "
	let timer=document.createElement("span")
	timer.className="tag"
	let tl=i.dataset["tl"]
	timer.dataset["tl"]=tl
	let button=document.createElement("button")
	button.innerText="📤"
	let lock=document.createElement("button")
	let locked=false
	lock.innerText="🔓"
	header.append(name)
	header.append(fullscore)
	header.append(timer)
	header.append(button)
	header.append(lock)
	i.prepend(header)
	let n=0
	let hour=tl/12
	let timeron = () => {
		let interval=setInterval(function(){
			if(n>tl){
				clearInterval(interval)
				try_notify("🔔 Time Limit Exceeded")
				calc_test(i)
				return
			}
			let part=Math.floor(n/hour+0.5)
			timer.innerText=clockemojis[part<<1]+clockemojis[part<<1|1]+" "+n+"/"+tl
			n+=1
		}, 1000)
		return interval
	}
	for(ch of i.querySelectorAll(".choose-area span")){
		let cb=document.createElement("input")
		cb.type="checkbox"
		ch.prepend(cb)
	}
	let inter=timeron()
	button.onclick=function(){
		clearInterval(inter)
		calc_test(i)
	}
	lock.onclick=function(){
		if(locked){
			lock.innerText="🔓"
			inter=timeron()
		}
		else{
			lock.innerText="🔒"
			clearInterval(inter)
		}
		locked=!locked
	}
}
for(let i of $(".select-is")){
	let choices=dictparse(i.dataset["chs"])
	let store=dictparse(i.dataset["st"])
	let select=document.createElement("select")
	let defval=i.dataset["de"]
	for(let k in choices){
		let option=document.createElement("option")
		option.value=k
		option.innerText=choices[k]
		select.append(option)
	}
	select.value=null
	let defkey=store[defval]
	if(defkey!=undefined){
		if(defkey[0]=="!"){
			defkey=defkey.substring(1)
			if(localStorage.getItem(defkey)==null)localStorage.setItem(defkey, "false")
		}
		else if(localStorage.getItem(defkey)==null){
			localStorage.setItem(defkey, "true")
			select.value=defval
		}
	}
	select.onchange=function(){
		let v=select.value
		let stk=store[v]
		if(stk!=undefined){
			if(stk[0]=="!"){
				stk=stk.substring(1)
				localStorage.setItem(stk, "false")
			}
			else localStorage.setItem(stk, "true")
			if(stk.startsWith("is-")){
				upd_trigger(stk)
			}
		}
	}
	i.append(select)
}
	})
})
require(['jquery', 'headroom', 'headroom-jquery'], function($, Headroom){
	window.Headroom = Headroom
	$(document).ready(function(){
		$("#documenter .docs-navbar").headroom({tolerance: {up: 10, down: 10 }})
	})
})
function copycodeblock(ev){
	let tar=ev.target
	let body=tar.parentNode.nextSibling
	let codes=body.querySelectorAll(".hljs-ln-code")
	let s=""
	for(let code of codes)s+=code.innerText+"\n"
	navigator.clipboard.writeText(s).then(
		function(){
			tar.innerText="✔"
			setTimeout(function(){
				tar.innerText="📋"
			},2000)
		},
		function(){window.alert("failed")}
	)
}
function buildmenu(){
	let lis=_buildmenu(menu, "docs/", 0)
	let dm=$(".docs-menu")[0]
	for(let li of lis){
		dm.appendChild(li)
	}
	let marked=JSON.parse(localStorage.getItem("marked"))
	if(marked==null)marked=[]
	$(".docs-chevron").bind("click", function(ev){
		ev.target.parentElement.nextElementSibling.classList.toggle("collapsed")
	})
	let loc=document.location
	let active=undefined
	for(let a of $(".docs-menu a.tocitem")){
		let pathname=a.href.substring(oril)
		if(pathname==loc.pathname){
			active=a
		}
		if(marked.includes(pathname)){
			a.parentNode.classList.add("li-marked")
		}
	}
	if(active!=undefined){
		if(activate_token(active)){
			let sidebar=$(".docs-menu")[0]
			sidebar.scrollTop = active.offsetTop - sidebar.offsetTop - 15;
		}
	}
}
function _buildmenu(vec, path, level){
	let ans=[]
	let l=vec.length
	let spl = (str) => {
		let pl=str.search('/')
		return [str.substring(0, pl), str.substring(pl+1)]
	}
	for(let i=1;i<l;i++){
		let e=vec[i]
		if(typeof e == "string"){
			let tup=spl(e)
			let a=document.createElement("a")
			a.className="tocitem"
			a.href=`${tURL}${path}${tup[0]}${filesuffix}`
			a.innerText=tup[1]
			let li=document.createElement("li")
			li.appendChild(a)
			ans.push(li)
		}
		else{
			let tup=spl(e[0])
			let a=document.createElement("a")
			a.className="tocitem"
			a.href=`${tURL}${path}${tup[0]}/index${filesuffix}`
			a.innerText=tup[1]
			let li=document.createElement("li")
			if(level==1){
				let iden=`menu-${path}${tup[0]}`
				let input=document.createElement("input")
				input.type="checkbox"
				input.className="collapse-toggle"
				input.id=iden
				li.appendChild(input)
				let label=document.createElement("label")
				label.className="tocitem"
				label.appendChild(a)
				label.for=iden
				let i=document.createElement("i")
				i.className="docs-chevron"
				label.appendChild(i)
				li.appendChild(label)
			}
			else{
				li.appendChild(a)
			}
			let clis=_buildmenu(e, `${path}${tup[0]}/`, level+1)
			let ul=document.createElement("ul")
			for(let cli of clis)ul.appendChild(cli)
			if(level==1)ul.className="collapsed"
			li.appendChild(ul)
			ans.push(li)
		}
	}
	return ans
}
function activate_token(node){
	let par=node.parentNode
	par.classList.add("is-active")
	let ul=document.createElement("ul")
	let flag=false
	for(let e of $(".content > h2")){
		let text=e.innerText
		let li=document.createElement("li")
		let a=document.createElement("a")
		a.className="tocitem"
		a.href=`#header-${text}`
		a.innerText=text
		li.appendChild(a)
		ul.appendChild(li)
		flag=true
	}
	if(flag){
		ul.className="internal"
		par.appendChild(ul)
	}
	return flag
}
function upd_trigger(key){
	let mode=localStorage.getItem(key)=="true" ? "block" : "none"
	for(let i of $(".checkis")){
		var chk=i.dataset["check"]
		if(chk==key){
			i.style.display=mode
		}
	}
}
function submit_fill(i){
	let inv=i.parentNode.children[1].value
	let isreg=i.dataset["isreg"]=="true"
	if(isreg){
		let reg=RegExp(i.dataset["ans"])
		i.style.backgroundColor= reg.exec(inv)===null ? "#f05020" : "#80af00"
	}else{
		let str=i.dataset["ans"]
		i.style.backgroundColor= inv==str ? "#80af00" : "#f05020"
	}
	setTimeout(function(){ i.style.backgroundColor=null }, 2000)
}
function toggle_mark(li){
	let link=li.lastElementChild.href.substring(oril)
	let marked=new Set(JSON.parse(localStorage.getItem("marked")))
	if(marked.has(link))marked.delete(link)
	else marked.add(link)
	localStorage.setItem("marked", JSON.stringify([...marked]))
}
function scroll_to_lines(from, to){
	let cb=$("code.hljs")[0]
	let nums=cb.querySelectorAll(".hljs-ln-numbers")
	for(let i=from; i<=to; i++){
		nums[i-1].style.backgroundColor="lightgreen"
	}
	nums[from-1].scrollIntoView()
}
require(['jquery', 'katex'], function($, katex){
	$(document).ready(function(){
		for(let e of $(".math"))katex.render(e.innerText, e,
			{ displayMode:false, throwOnError:false }
		)
		for(let e of $(".display-math"))katex.render(e.innerText, e,
			{ displayMode:true, throwOnError:false }
		)
	})
})
function try_notify(title){
	if(window.Notification && Notification.permission=="granted"){
		Notification.requestPermission(function(st){
			let n=new Notification(title)
		})
	}
	else{
		window.alert(title)
	}
}
function getchooseinput(node){
	let ins=node.querySelectorAll("input")
	let str=""
	for(let i=0;i<ins.length;i++){
		let input=ins[i]
		if(input.checked)str+=String.fromCharCode(65+i)
	}
	return str
}
function calc_test(node){
	let sum=0
	for(let ch of node.querySelectorAll(".choose-area")){
		let ans=ch.dataset["an"]
		let input=getchooseinput(ch)
		let tag=document.createElement("span")
		tag.className="tag"
		if(ans==undefined){
			let dict=dictparse(ch.dataset["dict"])
			let score=dict[input]
			let maxscore=Math.max(...Object.values(dict))
			if(score==undefined){
				tag.style.backgroundColor="red"
				tag.innerText="0/"+maxscore
			}
			else if(score!=maxscore){
				sum+=score
				tag.style.backgroundColor="yellow"
				tag.innerText=score+"/"+maxscore
			}
			else{
				sum+=score
				tag.style.backgroundColor="green"
				tag.innerText=score+"/"+score
			}
		}
		else{
			let score=Number(ch.dataset["sc"])
			if(input==ans){
				sum+=score
				tag.style.backgroundColor="green"
				tag.innerText=score+"/"+score
			}
			else{
				tag.style.backgroundColor="red"
				tag.innerText="0/"+score
			}
		}
		ch.firstElementChild.prepend(tag)
	}
	for(let fi of node.querySelectorAll(".fill-area")){
		let ans=fi.dataset["an"]
		let flag=false
		let score=Number(fi.dataset["sc"])
		let input=fi.lastElementChild.value
		if(ans==undefined){
			let reg=RegExp(fi.dataset["re"])
			if(reg.exec(input)!=null)flag=true
		}
		else if(ans==input)flag=true
		let first=fi.firstElementChild
		let tag=document.createElement("span")
		tag.className="tag"
		if(flag){
			sum+=score
			tag.style.backgroundColor="green"
			tag.innerText=score+"/"+score
		}
		else{
			tag.style.backgroundColor="red"
			tag.innerText="0/"+score
		}
		first.prepend(tag)
	}
	node.firstElementChild.children[1].innerText=" "+sum+"/"+node.dataset["fs"]
}
function dictparse(str){
	if(str.endsWith(','))str=str.substring(0, str.length-1)
	return JSON.parse("{"+str+"}")
}
