!classDefinition: #CarritoTusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #CarritoTusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CarritoTusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/10/2017 16:13:35'!
test01NewCartIsEmpty

self assert: CartFactory newCart isEmpty! !

!CarritoTusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/10/2017 18:58:11'!
test02CartWithItemsIsNotEmpty

self deny: (CartFactory newCart addItem:#item withQuantity: 1) isEmpty! !

!CarritoTusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/10/2017 18:58:26'!
test03WhenAddingItemCartContainsIt

self assert: ((CartFactory newCart addItem: #item withQuantity:1) contains: #item)! !

!CarritoTusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/10/2017 18:58:37'!
test04NotAddedItemIsNotInCart

self deny: ((CartFactory newCart addItem: #item withQuantity: 1) contains: #otheritem)! !

!CarritoTusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/10/2017 18:58:56'!
test05CartCanHaveMoreThanOneItem

self assert: (((CartFactory newCart addItem: #item withQuantity: 1) addItem: #otherItem withQuantity: 1) contains: #item)! !

!CarritoTusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/10/2017 18:59:16'!
test06AddingSameItemsXTimesEqualsAddingItemWithQuantityX

self assert: ((CartFactory newCart addItem: #item withQuantity: 1) addItem: #item withQuantity: 1) = (CartFactory newCart addItem: #item withQuantity:2)! !

!CarritoTusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/13/2017 15:01:07'!
test07CantAddNonPositiveQuantities

self should: [
		CartFactory  newCart addItem: #item withQuantity: 0
	]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError|
		self assert: anError messageText equals: Cart nonPositiveQuantity
	].
! !

!CarritoTusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/13/2017 15:02:52'!
test08CantAddNonIntegerQuantities

self should: [
		CartFactory newCart addItem: #item withQuantity: 3.1415
	]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError|
		self assert: anError messageText equals: Cart nonIntegerQuantity
	].
! !


!classDefinition: #Cart category: #'TusLibros-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'empty contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cart methodsFor: 'adding' stamp: 'DIC 6/13/2017 15:03:50'!
addItem: anItem withQuantity: aInteger
	aInteger > 0 ifFalse: [self error: self class nonPositiveQuantity].
	(aInteger isKindOf: Integer) ifFalse: [self error: self class nonIntegerQuantity].
	contents add: anItem withOccurrences: aInteger.
	^self! !


!Cart methodsFor: 'comparing' stamp: 'DIC 6/10/2017 18:12:09'!
= aCart
	^contents = aCart contents! !


!Cart methodsFor: 'testing' stamp: 'DIC 6/10/2017 17:55:35'!
contains: anItem
	^contents includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'DIC 6/10/2017 17:54:45'!
isEmpty
	^contents isEmpty ! !


!Cart methodsFor: 'initialization' stamp: 'DIC 6/10/2017 17:53:38'!
initialize
	contents := Bag new.
	^self! !


!Cart methodsFor: 'accessing' stamp: 'DIC 6/10/2017 18:12:36'!
contents
	^contents! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Solution'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'errors' stamp: 'DIC 6/13/2017 15:04:41'!
nonIntegerQuantity
	^'Quantity must be an integer'! !

!Cart class methodsFor: 'errors' stamp: 'DIC 6/13/2017 15:00:57'!
nonPositiveQuantity
	^'Quantity must be positive'! !


!classDefinition: #CartFactory category: #'TusLibros-Solution'!
Object subclass: #CartFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartFactory class' category: #'TusLibros-Solution'!
CartFactory class
	instanceVariableNames: ''!

!CartFactory class methodsFor: 'creating' stamp: 'DIC 6/10/2017 16:14:18'!
newCart
	^Cart new! !
