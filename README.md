# MonitorMethod
本demo是用于监测内存泄漏和UI渲染时间。具体博客详情[Runtime黑魔法](http://www.helloted.com/ios/2017/11/27/leakmonitor/)

使用方法：

```
pod 'HTMonitor'
```

监控有三种模式

```
typedef enum {
    HTMonitorTypeAll = 0,
    HTMonitorTypeUI,
    HTMonitorTypeMemory,
} HTMonitorType;
```

开启监控

```Objc
#import "HTMonitor.h"
[HTMonitor startMonitorType:HTMonitorTypeAll];
```

停止监控

```
#import "HTMonitor.h"
[HTMonitor stopMonitor:HTMonitorTypeAll];
```

