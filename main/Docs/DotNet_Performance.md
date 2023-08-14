#### BinaryPrimitives

1. 字节转换

2. 严格区分Endian

#### Span<>

1. 高效的连续内存范围操作值类型

2. 提供了比 ArraySegment 更易于理解和使用的内存局部视图

3. 不能在异步方法声明为变量

4. 不能作为全局变量

#### Memory<>

1. 提供了用于数据读写的Span属性

#### ArrayPool<>

1. 解决频繁申请内存和释放内存导致GC压力过大的场景

#### MemoryPool<>

1. 本质上还是使用了ArrayPool<>

2. 只提供了Rent功能，返回一个IMomoryOwner<>

3. Dispose等同于Return过程

#### MemoryMarshal

1. 操作一些更底层的Span或Memory操作

2. 获取Span的指针

3. Span泛型参数类型转换

4. ReadonlyMemory<>转换为Memory

#### RecyclableBufferWriter

1. 可回收的自动扩容BufferWriter，适合于大的缓冲区的场景

2. 缓冲区通过ArrayPool来租赁，用完之后，要Dispose()归还到ArrayPool

3. 优点是内存分配少，缺点是租赁比直接创建小的缓冲区还要慢。

#### ResizableBufferWriter

1. 自动扩容的BufferWriter，适合小的动态缓冲区的场景

2. 缓冲区通过new Array来创建，通过Array.Resize扩容

3. 优点是cpu性能好，缺点是内存分配高。

#### FixedBufferWriter

1. 固定大小缓冲区

2. 自己new的Array，包装为IBufferWriter对象

#### RecyclableMemoryStream

1. 池化`MemoryStream`底层buffer来降低内存占用率、GC暂停时间和GC次数


