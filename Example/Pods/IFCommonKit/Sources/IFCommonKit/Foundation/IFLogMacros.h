//
//  IFLogMacros.h
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#ifndef IFLogMacros_h
#define IFLogMacros_h

#if defined(__cplusplus)
#define IF_EXTERN extern "C"
#else
#define IF_EXTERN extern
#endif


//extern BOOL sTHLogNetwork;  // 底层网络所有log输出开关，默认关
//extern BOOL sTHLogLogin;    // 登录模块所有log输出开关，默认关


// 日志输出
#ifndef __OPTIMIZE__

// 如果点击跳转，需要安装 KZLinkedConsole 插件
// 🎈不可替换，插件里用于正则匹配，
// log中提示所在文件、行数、函数，蓝色 printf("\033[fg0,109,204;%s:%d🎈%s📢\033[;%s%s\n",
#define LXFPrintf(tag, format, ...)  printf("\n🎈%s:%d🎈%s%s%s\n", \
                                            [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, __PRETTY_FUNCTION__, \
                                            tag, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String])

// 下面可以打印彩色，但是需要安装 XcodeColors 插件
// 主要输出警告、注意类型的log，黄色
//LXFPrintf("❓\n\033[" "fg250,167,50;", format "\033[" ";", ## __VA_ARGS__);
#define NSLog(format, ...) { \
        LXFPrintf("📢📢\n", format, ## __VA_ARGS__); \
}

// 主要输出错误、危险类型的log，红色
//LXFPrintf("❌\n\033[" "fg148,0,0;", format "\033[" ";", ## __VA_ARGS__);
#define NSLogError(format, ...) { \
        LXFPrintf("❌❌\n", format, ## __VA_ARGS__); \
}

// 主要输出成功、通过类型的log，绿色
//LXFPrintf("♦️\n\033[" "fg91,183,91;", format "\033[" ";", ## __VA_ARGS__);
#define NSLogOK(format, ...) { \
        LXFPrintf("✅✅\n", format, ## __VA_ARGS__); \
}

#define NSLogLogin(...)        NSLogOK(__VA_ARGS__)
#define NSLogNetwork(...)       NSLog(__VA_ARGS__)

#else


#define NSLog(...) {}
#define NSLogError(...) {}
#define NSLogOK(...) {}
#define NSLogLogin(...) {}
#define NSLogNetwork(...) {}

#endif


#endif /* IFLogMacros_h */
