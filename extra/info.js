const buildmessage=`built at Tue Jul 26 07:47:32 2022`
const page_foot=`Powered by <a href='https://github.com/JuliaRoadmap/DoctreePages.jl'>DoctreePages.jl</a> and its dependencies.`
const tar_css=`css`
const filesuffix=`.html`
const menu=['',[`meta/Meta`,`about/关于`,`introduction/语言简介`,`how_to_learn/如何学习`,],[`basic/语法基础`,`setup_environment/环境配置`,`comment/注释`,`variable_basic/变量简介`,`int/整数`,`float/浮点数`,`bool/布尔`,`basicio/基础I/O`,`little_types/小类型`,`statement/条件`,`loop/循环`,`error/异常处理`,`range/范围`,`function/函数`,`vector/一维数组`,`string/字符与字符串`,`array/多维数组`,`dict/字典`,`io/I/O`,`scope/变量作用域`,`misc/查缺补漏`,`test/测验`,],[`advanced/语法进阶`,`introduction/介绍`,`typesystem/类型系统`,`struct/复合类型`,`method/方法`,`module/模块`,`meta/元编程`,],[`blog/专题`,`introduction/介绍`,[`packages/包的一切`,`introduction/包的简介`,`develop/包开发`,`stdlib/标准库`,`search/通过标签搜索文档`,`classify/部分包分类`,`practice/项目实践`,],[`daily/日报`,`about/关于`,],[`data_and_ai/数据与人工智能`,`introduction/数据分析简介`,`regressor/机器学习算法介绍`,`models/模型搜索`,`tunedmodel/TunedModel`,`data/数据处理`,`evaluate/评估模型`,],],[`packages/包的使用`,],[`ecosystem/生态`,],[`algorithms/算法`,],]
const configpaths=        {'headroom': 'https://cdnjs.cloudflare.com/ajax/libs/headroom/0.10.3/headroom.min',
		'jquery': 'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min',
		'headroom-jquery': 'https://cdnjs.cloudflare.com/ajax/libs/headroom/0.10.3/jQuery.headroom.min',
		'katex': 'https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.11.1/katex.min',
		'highlight': 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.5.1/highlight.min',
        'hljs-julia': 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.5.1/languages/julia.min',
		'hljs-julia-repl': 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.5.1/languages/julia-repl.min',
        'hljs-line-numbers': 'https://cdnjs.cloudflare.com/ajax/libs/highlightjs-line-numbers.js/2.8.0/highlightjs-line-numbers.min'}
        
const configshim=        {"hljs-julia-repl": { "deps": ["highlight"] },
		"hljs-julia": {"deps": ["highlight"]},
        "hljs-line-numbers": { "deps": ["highlight"]},
		"headroom-jquery": { "deps": [ "jquery", "headroom" ]}}
        
const hljs_languages=['julia', 'julia-repl']
const main_requirement=['jquery', 'highlight', 'hljs-julia', 'hljs-julia-repl', 'hljs-line-numbers']
