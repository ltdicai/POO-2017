!classDefinition: #TusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'anEmptyCatalog aBook anotherBook aBookCost aQuantity aCatalogWithABookAndBookCost aMoment aMoment20MinutesLater aMoment40MinutesLater anEmptyCart anEmptyCartWithEmptyCatalog anEmptyCartWithACatalog anotherEmptyCartWithACatalog aCreditCardWhichExpires2017_11_1 aSalesBook aSuccessfulMerchantProcessor aCreditCardWhichExpires2016_11_1 aStolenCreditMerchantProcessor aNotEnoughFundsMerchantProcessor aClientId aPassword aWrongPassword aMoment25MinutesLater'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 14:24:51'!
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
	
	"Merchant Processor"
	aSuccessfulMerchantProcessor := MerchantProcessor withSaleDo: [:anAmount :aCard | self].
	aStolenCreditMerchantProcessor := MerchantProcessor withSaleDo: [:anAmount :aCard | self error: MerchantProcessor stolenCreditCard ].
	aNotEnoughFundsMerchantProcessor := MerchantProcessor withSaleDo: [:anAmount :aCard | self error: MerchantProcessor notEnoughFunds ].
	
	" ClientIds "
	aClientId := 1.
	
	" passwords"
	aPassword := 'password'.
	aWrongPassword := 'raphael'.
	

	
	

! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 14:09:32'!
test01CantAddBookNotFromPublisher
	| aCart |
	
	aCart := anEmptyCartWithEmptyCatalog.
	
	self should: [aCart add: aBook]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Cart notFromPublisher.
			self deny: (aCart includes: aBook)]! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 00:20:41'!
test02AddedBookIsInCart
	| aCart |
	
	aCart := anEmptyCartWithACatalog.
	aCart add: aBook. 
	
	self assert: (aCart includes: aBook)
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 00:23:17'!
test03AddingSameBookSeveralTimesIsEqualToAddingInQuantity
	| aCart anotherCart |

	aCart := anEmptyCartWithACatalog.
	anotherCart := anotherEmptyCartWithACatalog.
	
	aCart add: aBook.
	aCart add: aBook.
	anotherCart add: aBook withQuantity: 2.
	
	self assert: aCart equals: anotherCart.
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 14:10:02'!
test04CantAddNonPositiveQuantity
	| aCart |
	aCart := anEmptyCartWithACatalog.
	
	self should: [aCart add: aBook withQuantity: -1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: Cart nonPositiveQuantity .
			self assert: (aCart quantityOf: aBook) equals: 0]
	
	
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 14:10:14'!
test05CantAddNonIntegerQuantity
	| aCart |

	aCart := anEmptyCartWithACatalog.
	
	self should: [aCart add: aBook withQuantity: 3.1415]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: Cart nonIntegerQuantity .
			self assert: (aCart quantityOf: aBook) equals: 0]
	
	
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 14:10:38'!
test06CantCheckoutWithEmptyCart
	| aCart aCashier aCreditCard aMerchantProcessor |

	aCart := anEmptyCartWithACatalog.
	aCreditCard := aCreditCardWhichExpires2017_11_1.
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: (DateAndTime year: 2017 month: 5 day: 1  hour: 2 minute: 10) withSalesBook: aSalesBook.
	aMerchantProcessor := aSuccessfulMerchantProcessor.
	
	self should: [aCashier checkout: aMerchantProcessor]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: Cashier checkoutEmptyCart.
			self assert: aSalesBook isEmpty]
	
	
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 14:20:23'!
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
			self assert: anError messageText equals: Cashier expiredCreditCard.
			self assert: aSalesBook isEmpty]
	
	
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 00:45:43'!
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

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 00:47:30'!
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

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 14:12:41'!
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
			self assert: anError messageText equals: MerchantProcessor stolenCreditCard.
			self assert: aSalesBook isEmpty]
	
	
	
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 14:13:26'!
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
			self assert: anError messageText equals: MerchantProcessor notEnoughFunds .
			self assert: aSalesBook isEmpty]
	
	
	
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 14:14:13'!
test12CantCreateCartForNotExistingClient
	| anInterface aClientIdToCartsMapping |
	aClientIdToCartsMapping := Dictionary new.
	anInterface := TusLibrosInterface withUsers: Dictionary new withCarts: aClientIdToCartsMapping withCatalog: anEmptyCatalog.
	
	self should: [anInterface createCartWithClientId: aClientId withPassword: aPassword atDateTime: aMoment]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: TusLibrosInterface clientDoesNotExist.
			self deny: (aClientIdToCartsMapping includesKey: aClientId)]! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 14:15:26'!
test13CantCreateCartForClientWithWrongPassword
	| anInterface aClientIdToCartsMapping aClientIdToPasswordMapping |
	aClientIdToCartsMapping := Dictionary new.
	aClientIdToPasswordMapping := Dictionary new.
	aClientIdToPasswordMapping at: aClientId put: aPassword.
	anInterface := TusLibrosInterface withUsers: aClientIdToPasswordMapping withCarts: aClientIdToCartsMapping withCatalog: anEmptyCatalog.
	
	self should: [anInterface createCartWithClientId: aClientId withPassword: aWrongPassword atDateTime: aMoment]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: TusLibrosInterface incorrectPassword.
			self deny: (aClientIdToCartsMapping includesKey: aClientId)]! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 01:04:04'!
test14NewCartIsAssociatedWithClientId
	| anInterface aClientIdToCartsMapping aClientIdToPasswordMapping aCartId|
	aClientIdToCartsMapping := Dictionary new.
	aClientIdToPasswordMapping := Dictionary new.
	aClientIdToPasswordMapping at: aClientId put: aPassword.
	anInterface := TusLibrosInterface withUsers: aClientIdToPasswordMapping withCarts: aClientIdToCartsMapping withCatalog: anEmptyCatalog.
	
	aCartId := anInterface createCartWithClientId: aClientId withPassword: aPassword atDateTime: aMoment.
	
	self assert: ((aClientIdToCartsMapping at: aClientId) includes: aCartId).
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 14:16:05'!
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
			self assert: anError messageText equals: TusLibrosInterface cartDoesNotExist]
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 01:07:05'!
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

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 14:16:36'!
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
			self assert: anError messageText equals: TusLibrosInterface cartDoesNotExist ].
	
	

	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 14:16:50'!
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
			self assert: anError messageText equals: TusLibrosInterface cartDoesNotExist]
	
	

	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 01:11:08'!
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

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 14:17:08'!
test20CantListPurchasesForNonExistingClientId
	| anInterface aClientIdToCartsMapping |
	aClientIdToCartsMapping := Dictionary new.
	anInterface := TusLibrosInterface withUsers: Dictionary new withCarts: aClientIdToCartsMapping withCatalog: anEmptyCatalog.
	
	self should: [anInterface listPurchasesWithClientId: aClientId withPassword: aPassword]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: TusLibrosInterface clientDoesNotExist ]
	
	
	

	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 14:25:22'!
test21CantCreateCashierWithExpiredCart
	| aCart|
	aCart := anEmptyCartWithACatalog.
	
	self should: [Cashier withCart: aCart withCreditCard: aCreditCardWhichExpires2017_11_1 atDate: aMoment40MinutesLater withSalesBook: aSalesBook.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: Cashier cartHasExpired]
	

	

	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 14:17:57'!
test22CantListPurchasesForClientWithWrongPassword
	| anInterface aClientIdToCartsMapping aClientIdToPasswordMapping |
	aClientIdToCartsMapping := Dictionary new.
	aClientIdToPasswordMapping := Dictionary new.
	aClientIdToPasswordMapping at: aClientId put: aPassword.
	anInterface := TusLibrosInterface withUsers: aClientIdToPasswordMapping withCarts: aClientIdToCartsMapping withCatalog: anEmptyCatalog.
	
	self should: [anInterface listPurchasesWithClientId: aClientId withPassword: aWrongPassword]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: TusLibrosInterface incorrectPassword ]
	
	
	

	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 14:18:16'!
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
			self assert: anError messageText equals: TusLibrosInterface cartHasExpired ]
	

	

	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DIC 6/27/2017 14:18:29'!
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
			self assert: anError messageText equals: TusLibrosInterface cartHasExpired ]
	

	

	
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


!Cart methodsFor: 'testing' stamp: 'DIC 6/19/2017 20:33:35'!
includes: aBook
	^contents includes: aBook! !

!Cart methodsFor: 'testing' stamp: 'DIC 6/19/2017 23:41:17'!
isEmpty
	^contents isEmpty ! !

!Cart methodsFor: 'testing' stamp: 'DIC 6/19/2017 20:56:01'!
quantityOf: aBook
	^contents occurrencesOf: aBook! !


!Cart methodsFor: 'accessing' stamp: 'DIC 6/19/2017 20:46:04'!
contents
	^contents copy! !

!Cart methodsFor: 'accessing' stamp: 'DIC 6/25/2017 00:10:17'!
createdAt
	^createdAt copy! !

!Cart methodsFor: 'accessing' stamp: 'DIC 6/20/2017 01:04:56'!
totalAmount | totalAmount |
	totalAmount := 0.
	contents do: [:aBook |
		totalAmount := totalAmount + (catalog at: aBook)].
	^totalAmount 
	! !


!Cart methodsFor: 'adding' stamp: 'DIC 6/19/2017 23:28:43'!
add: aBook
	^self add: aBook withQuantity: 1.
	! !

!Cart methodsFor: 'adding' stamp: 'DIC 6/27/2017 14:09:09'!
add: aBook withQuantity: anInteger
	anInteger > 0 ifFalse: [self error: self class nonPositiveQuantity ].
	(anInteger isKindOf: Integer) ifFalse: [self error: self class nonIntegerQuantity ].
	(catalog keys includes: aBook) ifFalse: [self error: self class notFromPublisher ]. 
	contents add: aBook withOccurrences: anInteger.
	^self! !


!Cart methodsFor: 'initializing' stamp: 'DIC 6/24/2017 23:45:41'!
initializeWithCatalog: aCatalog createdAt: aDateTime
	catalog := aCatalog.
	createdAt := aDateTime.
	contents := Bag new.
	^self! !

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

!Cart class methodsFor: 'errors' stamp: 'DIC 6/27/2017 14:07:59'!
notFromPublisher
	^'Book is not from publisher'! !


!Cart class methodsFor: 'creation' stamp: 'DIC 6/24/2017 23:45:08'!
withCatalog: aCatalog createdAt: aDateTime
	^self new initializeWithCatalog: aCatalog createdAt: aDateTime! !


!classDefinition: #Cashier category: #'TusLibros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'cart card currentDate salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cashier methodsFor: 'operations' stamp: 'DIC 6/27/2017 14:20:59'!
checkout: aMerchantProcessor
	| totalAmount |
	cart isEmpty ifTrue: [self error: self class checkoutEmptyCart ].
	(card isExpiredAt: currentDate) ifTrue: [self error: self class expiredCreditCard ].
	
	totalAmount := cart totalAmount.
	aMerchantProcessor debitAmount: totalAmount withCreditCard: card.
	salesBook addLast: totalAmount.
	
	^totalAmount! !


!Cashier methodsFor: 'initializing' stamp: 'DIC 6/24/2017 18:52:54'!
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

!Cashier class methodsFor: 'creation' stamp: 'DIC 6/27/2017 14:23:25'!
withCart: aCart withCreditCard: aCreditCard atDate: aDate withSalesBook: aSalesBook.
	aCart createdAt + (Duration minutes: 30) > aDate ifFalse: [^self error: self cartHasExpired ].
	
	^self new initializeWithCart: aCart withCreditCard: aCreditCard atDate: aDate withSalesBook: aSalesBook.! !


!Cashier class methodsFor: 'errors' stamp: 'DIC 6/27/2017 14:23:54'!
cartHasExpired
	^'Cart has expired'! !

!Cashier class methodsFor: 'errors' stamp: 'DIC 6/27/2017 14:11:37'!
checkoutEmptyCart
	^'Cant checkout empty cart'! !

!Cashier class methodsFor: 'errors' stamp: 'DIC 6/27/2017 14:20:37'!
expiredCreditCard
	^'Credit card is expired'! !


!classDefinition: #CreditCard category: #'TusLibros-Solution'!
Object subclass: #CreditCard
	instanceVariableNames: 'expireDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CreditCard methodsFor: 'initialization' stamp: 'DIC 6/19/2017 23:56:29'!
initializeWithExpireDate: aDate 
	expireDate := aDate.
	^self! !

!CreditCard methodsFor: 'initialization' stamp: 'DIC 6/20/2017 00:05:11'!
isExpiredAt: aDate
	^expireDate < aDate! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Solution'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'creation' stamp: 'DIC 6/19/2017 23:56:00'!
withExpireDate: aDate 
	^self new initializeWithExpireDate: aDate! !


!classDefinition: #MerchantProcessor category: #'TusLibros-Solution'!
Object subclass: #MerchantProcessor
	instanceVariableNames: 'saleAction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!MerchantProcessor methodsFor: 'initialization' stamp: 'DIC 6/24/2017 19:22:54'!
initializeWithSaleDo: aMethod
	saleAction := aMethod.
	^self! !


!MerchantProcessor methodsFor: 'operating' stamp: 'DIC 6/24/2017 19:23:48'!
debitAmount: anAmount withCreditCard: aCreditCard 
	saleAction value: anAmount value: aCreditCard.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: #'TusLibros-Solution'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'creation' stamp: 'DIC 6/24/2017 19:22:17'!
withSaleDo: aMethod
	^self new initializeWithSaleDo: aMethod
	! !


!MerchantProcessor class methodsFor: 'errors' stamp: 'DIC 6/27/2017 14:13:43'!
notEnoughFunds
	^'Not enough funds'! !

!MerchantProcessor class methodsFor: 'errors' stamp: 'DIC 6/27/2017 14:13:00'!
stolenCreditCard
	^'Credit card is stolen'! !


!classDefinition: #TusLibrosInterface category: #'TusLibros-Solution'!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'users carts catalog cartMapping lastCartId purchasesMapping salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosInterface methodsFor: 'endpoints' stamp: 'DIC 6/26/2017 23:57:38'!
addToCart: aCartId thisBook: aBook withQuantity: aQuantity atDateTime: aDateTime
	| cart |
	cart := self findAndValidateCart: aCartId atDateTime: aDateTime.
	cart add: aBook withQuantity: aQuantity.
	^self
	
	! !

!TusLibrosInterface methodsFor: 'endpoints' stamp: 'DIC 6/27/2017 00:07:32'!
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

!TusLibrosInterface methodsFor: 'endpoints' stamp: 'DIC 6/27/2017 01:42:03'!
createCartWithClientId: aClientId withPassword: aPassword atDateTime: aDateAndTime 
	| newCart newCartId |
	self validateClientId: aClientId withPassword: aPassword.
	
	newCart := Cart withCatalog: catalog createdAt: aDateAndTime.
	newCartId := lastCartId +1.
	lastCartId := newCartId.
	
	cartMapping at: newCartId put: newCart.
	(carts at: aClientId ifAbsentPut: Set new) add: newCartId.
	^newCartId! !

!TusLibrosInterface methodsFor: 'endpoints' stamp: 'DIC 6/27/2017 00:06:25'!
listCart: aCartId atDateTime: aDateTime
	| aCart |
	aCart := self findAndValidateCart: aCartId atDateTime: aDateTime.
	^aCart contents ! !

!TusLibrosInterface methodsFor: 'endpoints' stamp: 'DIC 6/27/2017 01:41:43'!
listPurchasesWithClientId: aClientId withPassword: aPassword 
	self validateClientId: aClientId withPassword: aPassword.
		
	^purchasesMapping at:aClientId ifAbsent: [ | clientAccountSummary |
		clientAccountSummary := Dictionary new.
		clientAccountSummary at: 'purchases' put: Bag new.
		clientAccountSummary at: 'total_amount' put: 0.
		^clientAccountSummary]
! !


!TusLibrosInterface methodsFor: 'private' stamp: 'DIC 6/27/2017 14:22:43'!
findAndValidateCart: aCartId atDateTime: aDateTime
	| aCart |
	aCart := cartMapping at: aCartId ifAbsent: [^self error: self class cartDoesNotExist ].
	aCart createdAt + (Duration minutes: 30) > aDateTime ifFalse: [^self error: self class cartHasExpired ].
	^aCart
	! !

!TusLibrosInterface methodsFor: 'private' stamp: 'DIC 6/27/2017 14:23:01'!
validateClientId: aClientId withPassword: aPassword
	| clientPassword |
	clientPassword := users at: aClientId ifAbsent: [^self error: self class clientDoesNotExist ].
	clientPassword = aPassword ifFalse: [^self error: self class incorrectPassword ].
	! !


!TusLibrosInterface methodsFor: 'initialization' stamp: 'DIC 6/25/2017 00:38:33'!
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

!TusLibrosInterface class methodsFor: 'creation' stamp: 'DIC 6/24/2017 20:49:24'!
withUsers: aUserCollection withCarts: aCartCollection withCatalog: aCatalog
	^self new withUsers: aUserCollection withCarts: aCartCollection withCatalog: aCatalog! !


!TusLibrosInterface class methodsFor: 'errors' stamp: 'DIC 6/27/2017 14:16:17'!
cartDoesNotExist
	^'Cart does not exist'! !

!TusLibrosInterface class methodsFor: 'errors' stamp: 'DIC 6/27/2017 14:17:43'!
cartHasExpired
	^'Cart has expired'! !

!TusLibrosInterface class methodsFor: 'errors' stamp: 'DIC 6/27/2017 14:14:29'!
clientDoesNotExist
	^'Client does not exists'! !

!TusLibrosInterface class methodsFor: 'errors' stamp: 'DIC 6/27/2017 14:15:41'!
incorrectPassword
	^'Incorrect password'! !
