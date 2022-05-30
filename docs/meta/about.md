# 关于
`JuliaRoadmap`是一个计划，旨在帮助用户更好地了解、掌握和精通Julia，提供学习路径、资料整合和现有经验，提供对应练习，解决现有中文文档的不符合认知规律等问题。[如何贡献](../../CONTRIBUTING.md)\
本项目文档部分采用[知识共享署名-非商业性使用-相同方式共享 4.0 国际许可协议](https://creativecommons.org/licenses/by-nc-sa/4.0/)进行许可（来源标注在相应页面末），代码部分采用MIT license进行许可

## 网站功能
- 上方的齿轮状按钮可以用于调节亮/暗色模式
- 侧边栏可以用于跳转（其中章节名跳转到索引页面）
- 双击标题可以复制链接
- 双击代码块可以复制代码
- 下方的讨论区可以在注册github后进行讨论（看不到可以尝试刷新）

## 设置
```insert-html
<section class="modal-card-body">
	<p>
		<label class="label">您是否有使用编程语言的相关经验？</label>
		<div class="select">
			<select id="is-newbie">
				<option value="yes" selected="selected">是</option>
				<option value="no">否</option>
			</select>
		</div>
	</p>
	<script>
		var is_n=document.getElementById("is-newbie")
		is_n.onchange=function(){
			var is_newbie=is_n.value
			localStorage.setItem("is-newbie",is_newbie=="no")
		}
	</script>
</section>
```
