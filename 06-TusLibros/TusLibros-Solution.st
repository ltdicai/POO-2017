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

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/20/2017 01:06:44'!
test01CantAddBookNotFromPublisher
| aCatalog aCart aBook |
	aCatalog := Dictionary new.
	aBook := #book.
	aCart := Cart withCatalog: aCatalog.
	
	self should: [aCart add: aBook]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError|
			self assert: anError messageText equals: 'NO'.
			self deny: (aCart includes: aBook)]! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/20/2017 01:10:14'!
test02AddedBookIsInCart
| aCatalog aCart aBook aBookCost|
	aBook := #book.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	aCart := Cart withCatalog: aCatalog.
	
	aCart add: aBook. 
	
	self assert: (aCart includes: aBook)
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/20/2017 01:10:39'!
test03AddingSameBookSeveralTimesIsEqualToAddingInQuantity
| aCatalog aCart anotherCart aBook aBookCost|
	aBook := #book.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
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

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/20/2017 01:11:12'!
test05CantAddNonIntegerQuantity
| aCatalog aCart aBook aBookCost|
	aBook := #book.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	aCart := Cart withCatalog: aCatalog.
	
	self should: [aCart add: aBook withQuantity: 3.1415]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'NO/'.
			self assert: (aCart quantityOf: aBook) equals: 0]
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/20/2017 00:23:26'!
test06CantCheckoutWithEmptyCart
| aCatalog aCart aCashier aCreditCard|
	aCatalog := Set new.
	aCart := Cart withCatalog: aCatalog.
	aCreditCard := CreditCard withExpireDate: (Date year: 2017 month: 11 day: 1).
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: (Date year: 2017 month: 5 day: 1).
	
	self should: [aCashier checkout]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'NO.Empty'.
			"self assert: no se hizo registro la compra"]
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/20/2017 01:10:59'!
test07CantCheckoutWithExpiredCreditCard
| aCatalog aCart aBook aBookCost aCashier anExpiredCreditCard|
	aBook := #book.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	aCart := Cart withCatalog: aCatalog.
	anExpiredCreditCard := CreditCard withExpireDate: (Date year: 2017 month: 5 day: 1).
	aCart add: aBook.
	aCashier := Cashier withCart: aCart withCreditCard: anExpiredCreditCard atDate: (Date year: 2017 month: 8 day: 1).
	
	self should: [aCashier checkout]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'NO.Expired'.
			"self assert: no se hizo registro la compra"]
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/22/2017 19:35:20'!
test08SuccessfulCheckoutReturnsTotalValue
	| aCatalog aCart aBook aCashier aCreditCard aBookCost |
	aBook := #book.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	aCart := Cart withCatalog: aCatalog.
	aCreditCard := CreditCard withExpireDate: (Date year: 2017 month: 11 day: 1).
	aCart add: aBook.
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: (Date year: 2017 month: 5 day: 1) .
	
	self assert: aCashier checkout equals: aBookCost
	
	
	
	! !


!classDefinition: #Cart category: #'TusLibros-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'catalog contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cart methodsFor: 'adding' stamp: 'DIC 6/13/2017 15:03:50'!
addItem: anItem withQuantity: aInteger
	aInteger > 0 ifFalse: [self error: self class nonPositiveQuantity].
	(aInteger isKindOf: Integer) ifFalse: [self error: self class nonIntegerQuantity].
	contents add: anItem withOccurrences: aInteger.
	^self! !


!Cart methodsFor: 'comparing' stamp: 'DIC 6/19/2017 20:45:47'!
= aCart
	^contents = aCart contents! !


!Cart methodsFor: 'testing' stamp: 'DIC 6/10/2017 17:55:35'!
contains: anItem
	^contents includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'DIC 6/19/2017 23:41:17'!
isEmpty
	^contents isEmpty ! !


!Cart methodsFor: 'initialization' stamp: 'DIC 6/10/2017 17:53:38'!
initialize
	contents := Bag new.
	^self! !


!Cart methodsFor: 'accessing' stamp: 'DIC 6/19/2017 20:46:04'!
contents
	^contents copy! !


!Cart methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 23:28:43'!
add: aBook
	^self add: aBook withQuantity: 1.
	! !

!Cart methodsFor: 'as yet unclassified' stamp: 'DIC 6/20/2017 01:05:16'!
add: aBook withQuantity: anInteger
	anInteger > 0 ifFalse: [self error: 'NO+'].
	(anInteger isKindOf: Integer) ifFalse: [self error: 'NO/'].
	(catalog keys includes: aBook) ifFalse: [self error: 'NO']. 
	contents add: aBook withOccurrences: anInteger.
	^self! !

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

!Cart methodsFor: 'as yet unclassified' stamp: 'DIC 6/20/2017 01:04:56'!
totalAmount | totalAmount |
	totalAmount := 0.
	contents do: [:aBook |
		totalAmount := totalAmount + (catalog at: aBook)].
	^totalAmount 
	! !

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


!Cart class methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 20:28:41'!
withCatalog: aCatalog
	^self new initializeWithCatalog: aCatalog! !


!classDefinition: #Cashier category: #'TusLibros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'cart card currentDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'DIC 6/20/2017 00:18:47'!
checkout
	| totalAmount |
	cart isEmpty ifTrue: [self error: 'NO.Empty'].
	(card isExpiredAt: currentDate) ifTrue: [self error: 'NO.Expired'].
	
	totalAmount := cart totalAmount.
	self debitAmount: totalAmount withCreditCard: card.
	
	^totalAmount! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'DIC 6/17/2017 18:51:23'!
checkoutCart: aShoppingCart withCard: aCreditCard 
	aShoppingCart isEmpty ifTrue: [^self error: 'NOO'].
	aCreditCard isExpired ifTrue: [^self error: 'EXPIRED']! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'DIC 6/20/2017 01:06:26'!
debitAmount: anAmount withCreditCard: aCreditCard 
	^self! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'DIC 6/20/2017 00:20:51'!
initializeWithCart: aCart withCreditCard: aCreditCard atDate: aDate
	cart := aCart.
	card := aCreditCard.
	currentDate := aDate.
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'DIC 6/20/2017 00:22:10'!
withCart: aCart withCreditCard: aCreditCard atDate: aDate
	^self new initializeWithCart: aCart withCreditCard: aCreditCard atDate: aDate! !


!classDefinition: #CreditCard category: #'TusLibros-Solution'!
Object subclass: #CreditCard
	instanceVariableNames: 'expireDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 23:56:29'!
initializeWithExpireDate: aDate 
	expireDate := aDate.
	^self! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'DIC 6/17/2017 18:49:13'!
isExpired
	^true! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'DIC 6/20/2017 00:05:11'!
isExpiredAt: aDate
	^expireDate < aDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Solution'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 23:56:00'!
withExpireDate: aDate 
	^self new initializeWithExpireDate: aDate! !
