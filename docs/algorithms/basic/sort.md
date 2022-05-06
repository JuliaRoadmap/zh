# 排序
## 概念
`排序(sorting)`：将一组特定的数据按某种顺序进行排列

## 前置知识
- [交换](swap.md)

## 相关已有资源

## 选择排序
### 原理
每次找出第i小的元素，然后将这个元素与数组第i位元素交换

![](https://oi-wiki.org/basic/images/selection-sort-1-animate-example.svg)

### 示例
```jl
function selection_sort!(v::Vector{T}) where T<:Number
	l=length(v)
	for i in 1:l-1
		place=i
		for j in i+1:l
			if v[j]<v[place]
				place=j
			end
		end
		swap(v,i,place)
	end
end
```

### 数据
| 键 | 值 |
| --- | --- |
| 稳定 | false |
| 最优时间复杂度 | $O(n^2)$ |
| 平均时间复杂度 | $O(n^2)$ |
| 最坏时间复杂度 | $O(n^2)$ |

## 冒泡排序
### 原理
每次检查相邻两个元素，若前面的元素大于后面的元素，则交换

### 示例
```jl
function bubble_sort!(v::Vector{T}) where T<:Number
	l=length(v)
	while true
		flag=true
		for i in 1:l-1
			if v[i]>v[i+1]
				swap(v,i,i+1)
				flag=false
			end
		end
		if flag
			break
		end
	end
end
```

### 数据
| 键 | 值 |
| --- | --- |
| 稳定 | true |
| 最优时间复杂度 | $O(n)$ |
| 平均时间复杂度 | $O(n^2)$ |
| 最坏时间复杂度 | $O(n^2)$ |

## 插入排序
### 原理
将待排列元素划分为“已排序”和“未排序”两部分，每次从“未排序的”元素中选择一个插入到“已排序的”元素中的正确位置

![](https://oi-wiki.org/basic/images/insertion-sort-1-animate-example.svg)

### 示例
```jl
function insertion_sort!(v::Vector{T}) where T<:Number
	l=length(v)
	for i in 2:l
		val=v[i]
		j=i-1
		while j>0 && v[j]>val
			v[j+1]=v[j]
			j-=1
		end
		v[j+1]=val
	end
end
```

### 数据
| 键 | 值 |
| --- | --- |
| 稳定 | true |
| 最优时间复杂度 | $O(n)$ |
| 平均时间复杂度 | $O(n^2)$ |
| 最坏时间复杂度 | $O(n^2)$ |

## 快速排序
### 原理
1. 将数列划分为两部分（要求保证相对大小关系）
2. 递归到两个子序列中分别进行快速排序

### 示例
```jl
function quick_sort!(v::Vector{T},first::Int=1,last::Int=length(v)) where T<:Number
	if first>=last
		return
	end
	midval=v[first]
	p=first
	q=last
	while p<q
		while v[q]>midval && p<q
			q-=1
		end
		v[p]=v[q]
		while v[p]<midval && p<q
			p+=1
		end
		v[q]=v[p]
	end
	v[p]=midval
	quick_sort!(v,first,p-1)
	quick_sort!(v,p+1,last)
end
```

### 数据
| 键 | 值 |
| --- | --- |
| 稳定 | false |
| 最优时间复杂度 | $O(nlogn)$ |
| 平均时间复杂度 | $O(nlogn)$ |
| 最坏时间复杂度 | $O(n^2)$ |

## 归并排序
### 原理
1. 将数列划分为两部分
2. 对两个子序列进行归并排序
3. 合并两个子序列

### 示例
```jl
function merge_sort!(v::Vector{T},first::Int=1,last::Int=length(v);temp::Vector{T}=Vector{T}(undef,length(v))) where T<:Number
	if first>=last
		return
	end
	mid=(first+last)>>1
	merge_sort!(v,first,mid;temp=temp)
	merge_sort!(v,mid+1,last;temp=temp)
	lpos=first
	rpos=mid+1
	for t in 1:last-first+1
		if lpos<=mid && (rpos>last || v[lpos]<v[rpos])
            temp[t]=v[lpos]
            lpos+=1
        else
            temp[t]=v[rpos]
            rpos+=1
        end
    end
    for i in 0:last-first
        v[i+first]=temp[i+1]
    end
end
```

### 数据
| 键 | 值 |
| --- | --- |
| 稳定 | true |
| 最优时间复杂度 | $O(nlogn)$ |
| 平均时间复杂度 | $O(nlogn)$ |
| 最坏时间复杂度 | $O(nlogn)$ |

[^1]: https://oi-wiki.org/basic/sort-intro/
[^2]: https://www.luogu.com.cn/blog/Victory-Defeat/qian-xi-sort
