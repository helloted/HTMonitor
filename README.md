# MonitorMethod
本demo是用于监测内存泄漏和UI渲染时间。具体博客详情[Runtime黑魔法](http://www.helloted.com/ios/2017/11/27/leakmonitor/)

使用方法：

```
pod 'HTMonitor'
```

监控有下面几种模式

```objc
typedef enum {
    HTMonitorTypeAll = 0,
    HTMonitorTypeUILoadTime,  // UI 加载时间
    HTMonitorTypeUILag,  // UI卡顿检测
    HTMonitorTypeMemoryLeak,  //内存泄漏检测
    HTMonitorTypeFPS, // 监控屏幕FPS
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

