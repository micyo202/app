//
//  ServerMarcos.h
//  app
//
//  Created by apple on 2020/12/30.
//

#ifndef ServerMarcos_h
#define ServerMarcos_h

#if DEBUG

#define SERVER_URL  @"http://localhost:8080"               // 开发/测试 地址

#else

#define SERVER_URL  @"https://localhost:8080"               // 生产地址

#endif

#endif /* ServerMarcos_h */
