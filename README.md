GCExtension
============




GCExtension是一个针对苹果iOS的CocoaTouch框架的扩展。
----------------




##	关于target-action设计的扩展
CocoaTouch框架大量的使用了[target-action](https://developer.apple.com/library/ios/documentation/general/conceptual/Devpedia-CocoaApp/TargetAction.html)的设计，这种设计很优秀，把事件的接收者(target)和事件的处理方法(action)动态的绑定起来，实现了高度的灵活性。

GCExtension对常见的target-action进行了扩展，用block代替target-action，可以减少一些代码的复杂性，为沉重的ViewController的减少一些方法代码。

target-action模式代码：

	- (void)setupButton {
	    UIButton* button = ...;
	    [button addTarget:self action:@selector(actionForButton:)
		 forControlEvents:UIControlEventTouchUpInside];
	}
	- (void)actionForButton:(id)sender {
	    NSLog(@"%@", sender);
	}

使用GCExtension：

	- (void)setupButton {
	    __weak typeof(self) weakSelf = self;
	    UIButton* button = ...;
	    [button addControlEvents:UIControlEventTouchUpInside
	                      action:^(UIControl *control, NSSet *touches) {
	                          [weakSelf actionForButton:control];
	                      }];
	}

	- (void)actionForButton:(id)sender {
	    NSLog(@"%@", sender);
	}
	
或者写成：

	- (void)setupButton {
	    UIButton* button = ...;
	    [button addControlEvents:UIControlEventTouchUpInside
	                      action:^(UIControl *control, NSSet *touches) {
	                          NSLog(@"%@", control);
	                      }];
	}
	
目前已经支持的extension包括UIControl，UIGestureRecognize和NSTimer。详见Demo：TargetActionDemo。

##	关于delegate和dataSource的扩展

GCExtension用block作为property的方式代替delegate和dataSource。

苹果的MVC支持是很完善的，在UIKit当中大量使用了delegate和dataSource的设计，很好的做到了数据和View的分离。

MVC在设计上是一种很好的设计，将Model-ViewController-View分离开来，降低耦合性。但是在实际的使用当中，因为ViewController往往承担了太多的责任，代码量大，耦合性强，可重用性和可维护性降低。由此发展出一种MVC的变体，[MVVM](http://www.objc.io/issue-13/mvvm.html)(Model-View-ViewModel)。MVVM大大的减少了ViewController中的代码，可重用性和可维护性都提高不少。

MVVM虽然减轻了ViewController，但是在实际使用上也会有一些麻烦，

##	关于Category的属性的扩展

Objective-C的Category是一个很强大的功能，可以在不继承的情况下扩展方法。

但是却缺少扩展存储属性的方法，或者说缺少扩展weak属性的方法。

GCExtension里的NSObject+GCAccessor较为简单的实现了存储属性的扩展。

	/**
	 *  This extension is for add properties when your extension an exist class.
	 *  When you use this Class Extension. You must do some step as follows:
	 *  1   invoke the method |extensionAccessorGenerator| in your class's method |+load|.
	 *  2   overrid the extensionAccessor... methods. (exclusive |extensionAccessorGenerator|.
	 */

只需要重写Category的+load方法，调用+extensionAccessorGenerator方法。然后重写相关的方法即可(不需要的属性类型不用重写相应方法)。详见Demo：CategoryPropertyDemo。

####	注意：不可以用于NSObject类的扩展

##	关于KVO的扩展

NSObject提供的KVO功能很强大，很方便的管理了Model和View之间的数据绑定。

但是，

1、所有的监听回调都在|observeValueForKeyPath:ofObject:change:context:|这一个方法里，代码不易维护。

2、当监听的对象多了以后，容易在监听对象被销毁时忘记移除相应的监听，造成监听泄漏，埋下隐患，且难以调试。也容易在被监听对象销毁时忘记移除相应监听，造成crash。

GCExtension中的NSObject+GCKVO很好的解决这两点。详见Demo：KVODemo。

##	关于Notification的扩展
