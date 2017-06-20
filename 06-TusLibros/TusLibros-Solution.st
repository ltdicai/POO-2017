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


!classDefinition: #TusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 20:28:09'!
test01CantAddBookNotFromPublisher
| aCatalog aCart aBook |
	aCatalog := Set new.
	aBook := #book.
	aCart := Cart withCatalog: aCatalog.
	
	self should: [aCart add: aBook]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError|
			self assert: anError messageText equals: 'NO'.
			self deny: (aCart includes: aBook)]! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 20:36:43'!
test02AddedBookIsInCart
| aCatalog aCart aBook |
	aBook := #book.
	aCatalog := Set with: aBook.
	aCart := Cart withCatalog: aCatalog.
	
	aCart add: aBook. 
	
	self assert: (aCart includes: aBook)
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 20:42:22'!
test03AddingSameBookSeveralTimesIsEqualToAddingInQuantity
| aCatalog aCart anotherCart aBook |
	aBook := #book.
	aCatalog := Set with: aBook.
	aCart := Cart withCatalog: aCatalog.
	anotherCart := Cart withCatalog: aCatalog.
	
	aCart add: aBook.
	aCart add: aBook.
	anotherCart add: aBook withQuantity: 2.
	
	self assert: aCart equals: anotherCart.
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 20:52:51'!
test04CantAddNonPositiveQuantity
| aCatalog aCart aBook |
	aBook := #book.
	aCatalog := Set with: aBook.
	aCart := Cart withCatalog: aCatalog.
	
	self should: [aCart add: aBook withQuantity: -1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'NO+'.
			self assert: (aCart quantityOf: aBook) equals: 0]
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 21:53:34'!
test05CantAddNonIntegerQuantity
| aCatalog aCart aBook |
	aBook := #book.
	aCatalog := Set with: aBook.
	aCart := Cart withCatalog: aCatalog.
	
	self should: [aCart add: aBook withQuantity: 3.1415]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'NO/'.
			self assert: (aCart quantityOf: aBook) equals: 0]
	
	
	
	! !


!classDefinition: #Cart category: #'TusLibros-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'catalog contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cart methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 20:45:47'!
= aCart
	^contents = aCart contents! !

!Cart methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 20:34:29'!
add: aBook
	(catalog includes: aBook) ifFalse: [self error: 'NO'].
	
	contents add: aBook.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 21:54:18'!
add: aBook withQuantity: anInteger
	anInteger > 0 ifFalse: [self error: 'NO+'].
	(anInteger isKindOf: Integer) ifFalse: [self error: 'NO/']. 
	contents add: aBook withOccurrences: anInteger.
	^self! !

!Cart methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 20:46:04'!
contents
	^contents copy! !

!Cart methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 20:33:35'!
includes: aBook
	^contents includes: aBook! !

!Cart methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 20:33:55'!
initializeWithCatalog: aCatalog
	catalog := aCatalog.
	contents := Bag new.
	^self! !

!Cart methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 20:56:01'!
quantityOf: aBook
	^contents occurrencesOf: aBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Solution'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 20:28:41'!
withCatalog: aCatalog
	^self new initializeWithCatalog: aCatalog! !
