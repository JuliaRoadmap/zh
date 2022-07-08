# Test的使用
```jl
julia> @test 1+1==2
Test Passed

julia> @testset "Exception" begin
           @test_throws BoundsError [1, 2, 3][4]
           @test_throws BoundsError [1, 2, 3][3]
           @test [1, 2, 3][4]
       end
Exception: Test Failed at REPL[8]:3
  Expression: ([1, 2, 3])[3]
    Expected: BoundsError
  No exception thrown
Stacktrace:
...
Exception: Error During Test at REPL[8]:4
...
Test Summary: | Pass  Fail  Error  Total
Exception     |    1     1      1      3
ERROR: Some tests did not pass: 1 passed, 1 failed, 1 errored, 0 broken.
```

## 对包测试
在利用Test对包测试时，应在`Project.toml`中放入
```jl
[extras]
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[targets]
test = ["Test"]
```

测试脚本默认位于`test/runtests.jl`，需手动导入`Test`和目标包

可以调用`Pkg.test`进行测试
