!classDefinition: #TusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'anEmptyCatalog aBook anotherBook aBookCost aQuantity aCatalogWithABookAndBookCost aMoment aMoment20MinutesLater aMoment40MinutesLater anEmptyCart anEmptyCartWithEmptyCatalog anEmptyCartWithACatalog anotherEmptyCartWithACatalog aCreditCardWhichExpires2017_11_1 aSalesBook aSuccessfulMerchantProcessor aCreditCardWhichExpires2016_11_1 aStolenCreditMerchantProcessor aNotEnoughFundsMerchantProcessor aClientId aPassword aWrongPassword aMoment25MinutesLater'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 01:07:23'!
setUp
	"Books"
	
	aBook := #ISBN000.
	
	anotherBook := #ISBN001.
	
	aBookCost := 5.
	
	" Date Times"
	
	aMoment := DateAndTime year: 2017 month: 6 day: 1  hour: 2 minute: 0.
	aMoment20MinutesLater := aMoment + (Duration minutes: 20).
	aMoment25MinutesLater := aMoment + (Duration minutes: 25).
	aMoment40MinutesLater := aMoment + (Duration minutes: 40).	
	
	"Catalogs"
	anEmptyCatalog := Dictionary new.
	
	aCatalogWithABookAndBookCost := Dictionary new.
	aCatalogWithABookAndBookCost at: aBook put: aBookCost.
	
	"Carts"
	
	anEmptyCartWithEmptyCatalog := Cart withCatalog: anEmptyCatalog copy createdAt: aMoment.
	
	anEmptyCartWithACatalog := Cart withCatalog: aCatalogWithABookAndBookCost copy createdAt: aMoment.
	
	anotherEmptyCartWithACatalog := Cart withCatalog: aCatalogWithABookAndBookCost copy createdAt: aMoment.
	
	aQuantity := 2.
	
	" CreditCards" 
	aCreditCardWhichExpires2017_11_1 := CreditCard withExpireDate: (DateAndTime year: 2017 month: 11 day: 1).
	aCreditCardWhichExpires2016_11_1 := CreditCard withExpireDate: (DateAndTime year: 2016 month: 11 day: 1).
	
	" Sales Book "
	aSalesBook := LinkedList new.
	
	""
	
	"Merchant Processor"
	aSuccessfulMerchantProcessor := MerchantProcessor withSaleDo: [:anAmount :aCard | self].
	aStolenCreditMerchantProcessor := MerchantProcessor withSaleDo: [:anAmount :aCard | self error: 'NO.Stolen'].
	aNotEnoughFundsMerchantProcessor := MerchantProcessor withSaleDo: [:anAmount :aCard | self error: 'NO.Amount'].
	
	
	" ClientIds "
	aClientId := 1.
	
	" passwords"
	aPassword := 'password'.
	aWrongPassword := 'raphael'.
	

	
	

! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 00:16:38'!
test01CantAddBookNotFromPublisher
	| aCart |
	
	aCart := anEmptyCartWithEmptyCatalog.
	
	self should: [aCart add: aBook]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError|
			self assert: anError messageText equals: 'NO'.
			self deny: (aCart includes: aBook)]! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 00:20:41'!
test02AddedBookIsInCart
	| aCart |
	
	aCart := anEmptyCartWithACatalog.
	aCart add: aBook. 
	
	self assert: (aCart includes: aBook)
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 00:23:17'!
test03AddingSameBookSeveralTimesIsEqualToAddingInQuantity
	| aCart anotherCart |

	aCart := anEmptyCartWithACatalog.
	anotherCart := anotherEmptyCartWithACatalog.
	
	aCart add: aBook.
	aCart add: aBook.
	anotherCart add: aBook withQuantity: 2.
	
	self assert: aCart equals: anotherCart.
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 00:24:25'!
test04CantAddNonPositiveQuantity
	| aCart |
	aCart := anEmptyCartWithACatalog.
	
	self should: [aCart add: aBook withQuantity: -1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'NO+'.
			self assert: (aCart quantityOf: aBook) equals: 0]
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 00:24:57'!
test05CantAddNonIntegerQuantity
	| aCart |

	aCart := anEmptyCartWithACatalog.
	
	self should: [aCart add: aBook withQuantity: 3.1415]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'NO/'.
			self assert: (aCart quantityOf: aBook) equals: 0]
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 00:32:24'!
test06CantCheckoutWithEmptyCart
	| aCart aCashier aCreditCard aMerchantProcessor |

	aCart := anEmptyCartWithACatalog.
	aCreditCard := aCreditCardWhichExpires2017_11_1.
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: (DateAndTime year: 2017 month: 5 day: 1  hour: 2 minute: 10) withSalesBook: aSalesBook.
	aMerchantProcessor := aSuccessfulMerchantProcessor.
	
	self should: [aCashier checkout: aMerchantProcessor]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'NO.Empty'.
			self assert: aSalesBook isEmpty]
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 00:42:50'!
test07CantCheckoutWithExpiredCreditCard
	| aCart aCashier anExpiredCreditCard aMerchantProcessor |

	aCart := anEmptyCartWithACatalog.
	anExpiredCreditCard := aCreditCardWhichExpires2016_11_1.
	aMerchantProcessor := aSuccessfulMerchantProcessor.
	
	aCart add: aBook.
	aCashier := Cashier withCart: aCart withCreditCard: anExpiredCreditCard atDate: (aMoment + (Duration minutes: 15)) withSalesBook: aSalesBook.
	
	self should: [aCashier checkout: aMerchantProcessor]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'NO.Expired'.
			self assert: aSalesBook isEmpty]
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 00:45:43'!
test08SuccessfulCheckoutReturnsTotalValue
	| aCart aCashier aCreditCard checkoutAmount aMerchantProcessor |
	aCart := anEmptyCartWithACatalog.
	aCreditCard := aCreditCardWhichExpires2017_11_1.
	aMerchantProcessor := aSuccessfulMerchantProcessor.
	
	aCart add: aBook withQuantity: aQuantity.
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: (aMoment + (Duration minutes: 15)) withSalesBook: aSalesBook.
	checkoutAmount := aCashier checkout: aMerchantProcessor .
	
	self assert: checkoutAmount equals: (aBookCost * aQuantity).
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 00:47:30'!
test09SuccessfulCheckoutRecordsLastSale
	| aCart aCashier aCreditCard checkoutAmount aMerchantProcessor |
	aCart := anEmptyCartWithACatalog.
	aCreditCard := aCreditCardWhichExpires2017_11_1.
	aMerchantProcessor := aSuccessfulMerchantProcessor.
	
	aCart add: aBook withQuantity: aQuantity.
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: (aMoment + (Duration minutes: 15)) withSalesBook: aSalesBook.
	checkoutAmount := aCashier checkout: aMerchantProcessor .
	
	self assert: aSalesBook last = checkoutAmount. 
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 00:48:30'!
test10CantCheckoutWithStolenCreditCard
	| aCart aCashier aCreditCard aMerchantProcessor |
	aCart := anEmptyCartWithACatalog.
	aCreditCard := aCreditCardWhichExpires2017_11_1.
	aMerchantProcessor := aStolenCreditMerchantProcessor.
	
	aCart add: aBook withQuantity: aQuantity.
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: (aMoment + (Duration minutes: 15)) withSalesBook: aSalesBook.
	
	self should: [aCashier checkout: aMerchantProcessor]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'NO.Stolen'.
			self assert: aSalesBook isEmpty]
	
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 00:51:25'!
test11CantCheckoutWithInsufficientAmount
	| aCart aCashier aCreditCard aMerchantProcessor |
	aCart := anEmptyCartWithACatalog.
	aCreditCard := aCreditCardWhichExpires2017_11_1.
	aMerchantProcessor := aNotEnoughFundsMerchantProcessor.
	
	aCart add: aBook withQuantity: aQuantity.
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: (aMoment + (Duration minutes: 15)) withSalesBook: aSalesBook.
	
	self should: [aCashier checkout: aMerchantProcessor]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'NO.Amount'.
			self assert: aSalesBook isEmpty]
	
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 01:00:14'!
test12CantCreateCartForNotExistingClient
	| anInterface aClientIdToCartsMapping |
	aClientIdToCartsMapping := Dictionary new.
	anInterface := TusLibrosInterface withUsers: Dictionary new withCarts: aClientIdToCartsMapping withCatalog: anEmptyCatalog.
	
	self should: [anInterface createCartWithClientId: aClientId withPassword: aPassword atDateTime: aMoment]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'No user'.
			self deny: (aClientIdToCartsMapping includesKey: aClientId)]! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 01:02:11'!
test13CantCreateCartForClientWithWrongPassword
	| anInterface aClientIdToCartsMapping aClientIdToPasswordMapping |
	aClientIdToCartsMapping := Dictionary new.
	aClientIdToPasswordMapping := Dictionary new.
	aClientIdToPasswordMapping at: aClientId put: aPassword.
	anInterface := TusLibrosInterface withUsers: aClientIdToPasswordMapping withCarts: aClientIdToCartsMapping withCatalog: anEmptyCatalog.
	
	self should: [anInterface createCartWithClientId: aClientId withPassword: aWrongPassword atDateTime: aMoment]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'No password'.
			self deny: (aClientIdToCartsMapping includesKey: aClientId)]! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 01:04:04'!
test14NewCartIsAssociatedWithClientId
	| anInterface aClientIdToCartsMapping aClientIdToPasswordMapping aCartId|
	aClientIdToCartsMapping := Dictionary new.
	aClientIdToPasswordMapping := Dictionary new.
	aClientIdToPasswordMapping at: aClientId put: aPassword.
	anInterface := TusLibrosInterface withUsers: aClientIdToPasswordMapping withCarts: aClientIdToCartsMapping withCatalog: anEmptyCatalog.
	
	aCartId := anInterface createCartWithClientId: aClientId withPassword: aPassword atDateTime: aMoment.
	
	self assert: ((aClientIdToCartsMapping at: aClientId) includes: aCartId).
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 01:05:24'!
test15CantAddBooksToNonExistingCart
	| anInterface aClientIdToCartsMapping aClientIdToPasswordMapping aCartId|
	aClientIdToCartsMapping := Dictionary new.
	aClientIdToPasswordMapping := Dictionary new.
	aClientIdToPasswordMapping at: aClientId put: aPassword.
	anInterface := TusLibrosInterface withUsers: aClientIdToPasswordMapping withCarts: aClientIdToCartsMapping withCatalog: aCatalogWithABookAndBookCost .
	aCartId := 42.
	
	self should: [anInterface addToCart: aCartId thisBook: aBook withQuantity: aQuantity atDateTime: aMoment]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'No cart']
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 01:07:05'!
test16AddedBookIsIncludedInCartList
	| anInterface aClientIdToCartsMapping aClientIdToPasswordMapping aCartId|
	aClientIdToCartsMapping := Dictionary new.
	aClientIdToPasswordMapping := Dictionary new.
	aClientIdToPasswordMapping at: aClientId put: aPassword.
	anInterface := TusLibrosInterface withUsers: aClientIdToPasswordMapping withCarts: aClientIdToCartsMapping withCatalog: aCatalogWithABookAndBookCost .
	
	aCartId := anInterface createCartWithClientId: aClientId withPassword: aPassword atDateTime: aMoment.
	anInterface addToCart: aCartId thisBook: aBook withQuantity: aQuantity atDateTime: aMoment20MinutesLater.
	
	self assert: ((anInterface listCart: aCartId atDateTime: aMoment25MinutesLater) occurrencesOf: aBook) equals: aQuantity 
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 01:08:38'!
test17CantListCartOfNonExistingCart
	| anInterface aClientIdToCartsMapping aClientIdToPasswordMapping aCartId|
	aClientIdToCartsMapping := Dictionary new.
	aClientIdToPasswordMapping := Dictionary new.
	aClientIdToPasswordMapping at: aClientId put: aPassword.
	anInterface := TusLibrosInterface withUsers: aClientIdToPasswordMapping withCarts: aClientIdToCartsMapping withCatalog: aCatalogWithABookAndBookCost .
	aCartId := 42.
	
	self should: [anInterface listCart: aCartId atDateTime: aMoment]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'No cart'].
	
	

	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 01:09:26'!
test18CantCheckoutNonExistingCart
	| anInterface aClientIdToCartsMapping aClientIdToPasswordMapping aCartId|
	aClientIdToCartsMapping := Dictionary new.
	aClientIdToPasswordMapping := Dictionary new.
	aClientIdToPasswordMapping at: aClientId put: aPassword.
	anInterface := TusLibrosInterface withUsers: aClientIdToPasswordMapping withCarts: aClientIdToCartsMapping withCatalog: aCatalogWithABookAndBookCost .
	aCartId := 42.
	
	self should: [anInterface checkOutCart: aCartId withCreditCard: aCreditCardWhichExpires2017_11_1 atDate: aMoment]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'No cart']
	
	

	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 01:11:08'!
test19SuccessfulCheckoutRecordPurchase
	|anInterface aClientIdToCartsMapping aClientIdToPasswordMapping aCartId aBagOfBooks aListOfPurchases |
	aClientIdToCartsMapping := Dictionary new.
	aClientIdToPasswordMapping := Dictionary new.
	aClientIdToPasswordMapping at: aClientId put: aPassword.
	anInterface := TusLibrosInterface withUsers: aClientIdToPasswordMapping withCarts: aClientIdToCartsMapping withCatalog: aCatalogWithABookAndBookCost .
	aListOfPurchases := Dictionary new.
	aBagOfBooks := Bag new.
	aBagOfBooks add: aBook withOccurrences: aQuantity.
	aListOfPurchases at: 'purchases' put: aBagOfBooks.
	aListOfPurchases at: 'total_amount' put: 10.
	
	aCartId := anInterface createCartWithClientId: aClientId withPassword: aPassword atDateTime: aMoment.
	anInterface addToCart: aCartId thisBook: aBook withQuantity: aQuantity atDateTime: aMoment20MinutesLater .
	anInterface checkOutCart: aCartId withCreditCard: aCreditCardWhichExpires2017_11_1 atDate: aMoment25MinutesLater.	
	
	self assert: (anInterface listPurchasesWithClientId: aClientId withPassword: aPassword) equals: aListOfPurchases.
	
	

	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 01:12:13'!
test20CantListPurchasesForNonExistingClientId
	| anInterface aClientIdToCartsMapping |
	aClientIdToCartsMapping := Dictionary new.
	anInterface := TusLibrosInterface withUsers: Dictionary new withCarts: aClientIdToCartsMapping withCatalog: anEmptyCatalog.
	
	self should: [anInterface listPurchasesWithClientId: aClientId withPassword: aPassword]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'No user']
	
	
	

	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 01:13:24'!
test21CantCreateCashierWithExpiredCart
	| aCart|
	aCart := anEmptyCartWithACatalog.
	
	self should: [Cashier withCart: aCart withCreditCard: aCreditCardWhichExpires2017_11_1 atDate: aMoment40MinutesLater withSalesBook: aSalesBook.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'Expired cart']
	

	

	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 01:14:10'!
test22CantListPurchasesForClientWithWrongPassword
	| anInterface aClientIdToCartsMapping aClientIdToPasswordMapping |
	aClientIdToCartsMapping := Dictionary new.
	aClientIdToPasswordMapping := Dictionary new.
	aClientIdToPasswordMapping at: aClientId put: aPassword.
	anInterface := TusLibrosInterface withUsers: aClientIdToPasswordMapping withCarts: aClientIdToCartsMapping withCatalog: anEmptyCatalog.
	
	self should: [anInterface listPurchasesWithClientId: aClientId withPassword: aWrongPassword]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'Wrong password']
	
	
	

	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 01:16:42'!
test23CantAddItemsToExpiredCart
	| aCartId anInterface aClientIdToCartsMapping aClientIdToPasswordMapping |
	aClientIdToCartsMapping := Dictionary new.
	aClientIdToPasswordMapping := Dictionary new.
	aClientIdToPasswordMapping at: aClientId put: aPassword.
	
	anInterface := TusLibrosInterface withUsers: aClientIdToPasswordMapping withCarts: aClientIdToCartsMapping withCatalog: aCatalogWithABookAndBookCost.
	aCartId := anInterface createCartWithClientId: aClientId withPassword: aPassword atDateTime: aMoment.
	
	self should: [anInterface addToCart: aCartId thisBook: aBook  withQuantity: aQuantity atDateTime: aMoment40MinutesLater ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'Expired cart']
	

	

	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 01:17:14'!
test24CantListCartForExpiredCart
	| aCartId anInterface aClientIdToCartsMapping aClientIdToPasswordMapping |
	aClientIdToCartsMapping := Dictionary new.
	aClientIdToPasswordMapping := Dictionary new.
	aClientIdToPasswordMapping at: aClientId put: aPassword.
	
	anInterface := TusLibrosInterface withUsers: aClientIdToPasswordMapping withCarts: aClientIdToCartsMapping withCatalog: aCatalogWithABookAndBookCost.
	aCartId := anInterface createCartWithClientId: aClientId withPassword: aPassword atDateTime: aMoment.
	anInterface addToCart: aCartId thisBook: aBook  withQuantity: aQuantity atDateTime: aMoment20MinutesLater.
	
	self should: [anInterface listCart: aCartId atDateTime: aMoment40MinutesLater ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'Expired cart']
	

	

	
	! !


!classDefinition: #Cart category: #'TusLibros-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'catalog contents createdAt'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cart methodsFor: 'comparing' stamp: 'DIC 6/19/2017 20:45:47'!
= aCart
	^contents = aCart contents! !


!Cart methodsFor: 'testing' stamp: 'DIC 6/19/2017 23:41:17'!
isEmpty
	^contents isEmpty ! !


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

!Cart methodsFor: 'as yet unclassified' stamp: 'DIC 6/25/2017 00:10:17'!
createdAt
	^createdAt copy! !

!Cart methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 20:33:35'!
includes: aBook
	^contents includes: aBook! !

!Cart methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 23:45:41'!
initializeWithCatalog: aCatalog createdAt: aDateTime
	catalog := aCatalog.
	createdAt := aDateTime.
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


!Cart class methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 23:45:08'!
withCatalog: aCatalog createdAt: aDateTime
	^self new initializeWithCatalog: aCatalog createdAt: aDateTime! !


!classDefinition: #Cashier category: #'TusLibros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'cart card currentDate salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 19:20:57'!
checkout: aMerchantProcessor
	| totalAmount |
	cart isEmpty ifTrue: [self error: 'NO.Empty'].
	(card isExpiredAt: currentDate) ifTrue: [self error: 'NO.Expired'].
	
	totalAmount := cart totalAmount.
	aMerchantProcessor debitAmount: totalAmount withCreditCard: card.
	salesBook addLast: totalAmount.
	
	^totalAmount! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 19:14:11'!
debitAmount: anAmount withCreditCard: aCreditCard 
	^merchantProcessor debitAmount: anAmount withCreditCard: aCreditCard! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 18:52:54'!
initializeWithCart: aCart withCreditCard: aCreditCard atDate: aDate withSalesBook: aSalesBook
	cart := aCart.
	card := aCreditCard.
	currentDate := aDate.
	salesBook := aSalesBook.
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'DIC 6/25/2017 00:17:22'!
withCart: aCart withCreditCard: aCreditCard atDate: aDate withSalesBook: aSalesBook.
	aCart createdAt + (Duration minutes: 30) > aDate ifFalse: [^self error: 'Expired cart'].
	
	^self new initializeWithCart: aCart withCreditCard: aCreditCard atDate: aDate withSalesBook: aSalesBook.! !


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


!classDefinition: #MerchantProcessor category: #'TusLibros-Solution'!
Object subclass: #MerchantProcessor
	instanceVariableNames: 'saleAction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 19:23:48'!
debitAmount: anAmount withCreditCard: aCreditCard 
	saleAction value: anAmount value: aCreditCard.! !

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 19:22:54'!
initializeWithSaleDo: aMethod
	saleAction := aMethod.
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: #'TusLibros-Solution'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 19:22:17'!
withSaleDo: aMethod
	^self new initializeWithSaleDo: aMethod
	! !


!classDefinition: #TusLibrosInterface category: #'TusLibros-Solution'!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'users carts catalog cartMapping lastCartId purchasesMapping salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'DIC 6/26/2017 23:57:38'!
addToCart: aCartId thisBook: aBook withQuantity: aQuantity atDateTime: aDateTime
	| cart |
	cart := self findAndValidateCart: aCartId atDateTime: aDateTime.
	cart add: aBook withQuantity: aQuantity.
	^self
	
	! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 00:07:32'!
checkOutCart: aCartId withCreditCard: aCreditCard atDate: aDateTime
	|aCart aCashier aClientId totalAmount purchasesPerClient totalAmountPerClient clientAccountSummary |
	aCart := self findAndValidateCart: aCartId atDateTime: aDateTime.
	
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: aDateTime withSalesBook: salesBook.
	
	totalAmount := aCashier checkout: (MerchantProcessor withSaleDo: [:anAmount :aCard | self]).
	
	carts keysAndValuesDo: [:clientId :cartIds | (cartIds includes: aCartId) ifTrue: [aClientId := clientId]].
	
	clientAccountSummary := purchasesMapping at: aClientId ifAbsentPut: Dictionary new.
	purchasesPerClient := clientAccountSummary at: 'purchases' ifAbsentPut: Bag new.
	totalAmountPerClient := clientAccountSummary at: 'total_amount' ifAbsentPut: 0.
	
	purchasesPerClient addAll: aCart contents.
	totalAmountPerClient := totalAmountPerClient + totalAmount.
	
	clientAccountSummary at: 'purchases' put: purchasesPerClient.
	clientAccountSummary at: 'total_amount' put: totalAmountPerClient.
	
	purchasesMapping at: aClientId put: clientAccountSummary.
	
	(carts at: aClientId) remove: aCartId.
	cartMapping removeKey: aCartId.
	! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'DIC 6/25/2017 00:30:51'!
createCartWithClientId: aClientId withPassword: aPassword atDateTime: aDateAndTime 
	| password newCart newCartId |
	password := users at: aClientId ifAbsent: [^self error: 'No user'].
	password = aPassword ifFalse: [^self error: 'No password'].
	
	newCart := Cart withCatalog: catalog createdAt: aDateAndTime.
	newCartId := lastCartId +1.
	lastCartId := newCartId.
	
	cartMapping at: newCartId put: newCart.
	(carts at: aClientId ifAbsentPut: Set new) add: newCartId.
	^newCartId! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'DIC 6/26/2017 23:56:22'!
findAndValidateCart: aCartId atDateTime: aDateTime
	| aCart |
	aCart := cartMapping at: aCartId ifAbsent: [^self error: 'No cart'].
	aCart createdAt + (Duration minutes: 30) > aDateTime ifFalse: [^self error: 'Expired cart'].
	^aCart
	! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 00:06:25'!
listCart: aCartId atDateTime: aDateTime
	| aCart |
	aCart := self findAndValidateCart: aCartId atDateTime: aDateTime.
	^aCart contents ! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'DIC 6/26/2017 23:19:07'!
listPurchasesWithClientId: aClientId withPassword: aPassword 
	| clientPassword|
	clientPassword := users at: aClientId ifAbsent: [^self error: 'No user'].
	clientPassword = aPassword ifFalse: [^self error: 'Wrong password'].
	
	
	^purchasesMapping at:aClientId ifAbsent: [ | clientAccountSummary |
		clientAccountSummary := Dictionary new.
		clientAccountSummary at: 'purchases' put: Bag new.
		clientAccountSummary at: 'total_amount' put: 0.
		^clientAccountSummary]
	
	
	"result End of block expected ->:= Dictionary new.
	result at: 'purchases' put: Set new.
	result at: 'total_amount' put: 0.
	
	cartIds := carts at: aClientId.
	cartIds do: [:aCartId | | aCart amount |
		aCart := cartMapping at: aCartId.
		(result at: 'purchases') add: aCart contents.
		amount := result at: 'total_amount'.
		result at: 'total_amount' put: aCart totalAmount + amount].
	
	^result"! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'DIC 6/25/2017 00:38:33'!
withUsers: anUserCollection withCarts: aCartCollection withCatalog: aCatalog
	users := anUserCollection.
	carts := aCartCollection.
	catalog := aCatalog.
	cartMapping := Dictionary new.
	purchasesMapping := Dictionary new.
	salesBook := LinkedList new.
	lastCartId := 0.
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: #'TusLibros-Solution'!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 20:49:24'!
withUsers: aUserCollection withCarts: aCartCollection withCatalog: aCatalog
	^self new withUsers: aUserCollection withCarts: aCartCollection withCatalog: aCatalog! !
