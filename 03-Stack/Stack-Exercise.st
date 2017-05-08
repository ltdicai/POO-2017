!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOEmptyStack category: #'Stack-Exercise'!
Object subclass: #OOEmptyStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOEmptyStack methodsFor: 'accessing' stamp: 'DIC 5/7/2017 22:48:06'!
getPreviousStack
	^self error: (OOStack stackEmptyErrorDescription)
	! !

!OOEmptyStack methodsFor: 'accessing' stamp: 'DIC 5/7/2017 22:47:38'!
getValue
	^self error: (OOStack stackEmptyErrorDescription)
	! !


!OOEmptyStack methodsFor: 'testing' stamp: 'DIC 5/7/2017 21:40:49'!
isEmpty
	^true! !


!classDefinition: #OONonEmptyStack category: #'Stack-Exercise'!
Object subclass: #OONonEmptyStack
	instanceVariableNames: 'previousStack stackValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONonEmptyStack methodsFor: 'initialization' stamp: 'DIC 5/7/2017 22:55:02'!
initializeWithValue: aValue andPreviousStack: aStack
	stackValue := aValue.
	previousStack := aStack.
	^self! !


!OONonEmptyStack methodsFor: 'testing' stamp: 'DIC 5/7/2017 21:41:17'!
isEmpty
	^false! !


!OONonEmptyStack methodsFor: 'accessing' stamp: 'DIC 5/7/2017 22:01:12'!
getPreviousStack
	^previousStack
	! !

!OONonEmptyStack methodsFor: 'accessing' stamp: 'DIC 5/7/2017 22:00:26'!
getValue
	^stackValue
	! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'actualStack size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'DIC 5/7/2017 23:07:40'!
initialize
	actualStack := OOEmptyStack new.
	size := 0.
	^self! !


!OOStack methodsFor: 'testing' stamp: 'DIC 5/7/2017 21:45:47'!
isEmpty
	^actualStack isEmpty! !


!OOStack methodsFor: 'accessing' stamp: 'DIC 5/7/2017 22:56:41'!
pop
	| stackValue |
	stackValue := actualStack getValue.
	actualStack := actualStack getPreviousStack.
	size := size - 1.
	^stackValue
	! !

!OOStack methodsFor: 'accessing' stamp: 'DIC 5/7/2017 22:56:26'!
push: anObject
	actualStack := (OONonEmptyStack new) initializeWithValue: anObject andPreviousStack: actualStack.
	size := size + 1.
	^self
	! !

!OOStack methodsFor: 'accessing' stamp: 'DIC 5/7/2017 22:56:15'!
size
	^size	! !

!OOStack methodsFor: 'accessing' stamp: 'DIC 5/7/2017 22:57:00'!
top
	^actualStack getValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !
