!classDefinition: #TusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'anEmptyCatalog aBook anotherBook aBookCost aQuantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/26/2017 23:52:49'!
setUp
	anEmptyCatalog := Dictionary new.
	aBook := #ISBN000.
	anotherBook := #ISBN001.
	aBookCost := 5.
	aQuantity := 2.
! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/26/2017 23:53:13'!
test01CantAddBookNotFromPublisher
| aCatalog aCart aBook |
	aCatalog := Dictionary new.
	aBook := #book.
	aCart := Cart withCatalog: aCatalog createdAt: (DateAndTime year: 2017 month: 6 day: 1  hour: 2 minute: 0).
	
	self should: [aCart add: aBook]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError|
			self assert: anError messageText equals: 'NO'.
			self deny: (aCart includes: aBook)]! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/26/2017 23:58:35'!
test02AddedBookIsInCart
| aCatalog aCart aBook aBookCost|
	aBook := #book.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	aCart := Cart withCatalog: aCatalog createdAt: (DateAndTime year: 2017 month: 6 day: 1  hour: 2 minute: 0).
	
	aCart add: aBook. 
	
	self assert: (aCart includes: aBook)
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 23:48:44'!
test03AddingSameBookSeveralTimesIsEqualToAddingInQuantity
| aCatalog aCart anotherCart aBook aBookCost|
	aBook := #book.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	aCart := Cart withCatalog: aCatalog createdAt: (DateAndTime year: 2017 month: 6 day: 1  hour: 2 minute: 0).
	anotherCart := Cart withCatalog: aCatalog createdAt: (DateAndTime year: 2017 month: 6 day: 1  hour: 2 minute: 0).
	
	aCart add: aBook.
	aCart add: aBook.
	anotherCart add: aBook withQuantity: 2.
	
	self assert: aCart equals: anotherCart.
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 23:48:54'!
test04CantAddNonPositiveQuantity
| aCatalog aCart aBook |
	aBook := #book.
	aCatalog := Set with: aBook.
	aCart := Cart withCatalog: aCatalog createdAt: (DateAndTime year: 2017 month: 6 day: 1  hour: 2 minute: 0).
	
	self should: [aCart add: aBook withQuantity: -1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'NO+'.
			self assert: (aCart quantityOf: aBook) equals: 0]
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 23:49:04'!
test05CantAddNonIntegerQuantity
| aCatalog aCart aBook aBookCost|
	aBook := #book.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	aCart := Cart withCatalog: aCatalog createdAt: (DateAndTime year: 2017 month: 6 day: 1  hour: 2 minute: 0).
	
	self should: [aCart add: aBook withQuantity: 3.1415]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'NO/'.
			self assert: (aCart quantityOf: aBook) equals: 0]
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/25/2017 00:20:02'!
test06CantCheckoutWithEmptyCart
| aCatalog aCart aCashier aCreditCard aSalesBook aMerchantProcessor |
	aCatalog := Set new.
	aCart := Cart withCatalog: aCatalog createdAt: (DateAndTime year: 2017 month: 5 day: 1  hour: 2 minute: 0).
	aCreditCard := CreditCard withExpireDate: (Date year: 2017 month: 11 day: 1).
	aSalesBook := LinkedList new.
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: (DateAndTime year: 2017 month: 5 day: 1  hour: 2 minute: 10) withSalesBook: aSalesBook.
	aMerchantProcessor := MerchantProcessor withSaleDo: [:anAmount :aCard | ^self].
	
	self should: [aCashier checkout: aMerchantProcessor]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'NO.Empty'.
			self assert: aSalesBook isEmpty]
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/25/2017 00:22:49'!
test07CantCheckoutWithExpiredCreditCard
| aCatalog aCart aBook aBookCost aCashier anExpiredCreditCard aSalesBook aMerchantProcessor |
	aBook := #book.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	aCart := Cart withCatalog: aCatalog createdAt: (DateAndTime year: 2017 month: 6 day: 1  hour: 2 minute: 0).
	anExpiredCreditCard := CreditCard withExpireDate: (DateAndTime year: 2017 month: 5 day: 1).
	aCart add: aBook.
	aSalesBook := LinkedList new.
	aCashier := Cashier withCart: aCart withCreditCard: anExpiredCreditCard atDate: (DateAndTime year: 2017 month: 6 day: 1  hour: 2 minute: 10) withSalesBook: aSalesBook.
	aMerchantProcessor := MerchantProcessor withSaleDo: [:anAmount :aCard | ^self].
	
	self should: [aCashier checkout: aMerchantProcessor]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'NO.Expired'.
			self assert: aSalesBook isEmpty]
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/25/2017 00:23:34'!
test08SuccessfulCheckoutReturnsTotalValue
	| aCatalog aCart aBook aCashier aCreditCard aBookCost aSalesBook checkoutAmount aMerchantProcessor |
	aBook := #book.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	aCart := Cart withCatalog: aCatalog createdAt: (DateAndTime year: 2017 month: 4 day: 1  hour: 2 minute: 0).
	aCreditCard := CreditCard withExpireDate: (DateAndTime year: 2017 month: 11 day: 1).
	aCart add: aBook.
	aSalesBook := LinkedList new.
	aMerchantProcessor := MerchantProcessor withSaleDo: [:anAmount :aCard | ^self].
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: (DateAndTime year: 2017 month: 4 day: 1  hour: 2 minute: 0) withSalesBook: aSalesBook.
	
	checkoutAmount := aCashier checkout: aMerchantProcessor .
	
	self assert: checkoutAmount equals: aBookCost.
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/25/2017 00:24:04'!
test09SuccessfulCheckoutRecordsLastSale
	| aCatalog aCart aBook aCashier aCreditCard aBookCost aSalesBook checkoutAmount aMerchantProcessor |
	aBook := #book.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	aCart := Cart withCatalog: aCatalog createdAt: (DateAndTime year: 2017 month: 5 day: 1  hour: 2 minute: 0).
	aCreditCard := CreditCard withExpireDate: (DateAndTime year: 2017 month: 11 day: 1).
	aCart add: aBook.
	aSalesBook := LinkedList new.
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: (DateAndTime year: 2017 month: 5 day: 1  hour: 2 minute: 0) withSalesBook: aSalesBook.
	aMerchantProcessor := MerchantProcessor withSaleDo: [:anAmount :aCard | ^self].
	checkoutAmount := aCashier checkout: aMerchantProcessor.
	
	self assert: aSalesBook last = checkoutAmount. 
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/25/2017 00:24:33'!
test10CantCheckoutWithStolenCreditCard
	| aCatalog aCart aBook aCashier aCreditCard aBookCost aSalesBook aMerchantProcessor |
	aBook := #book.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	aCart := Cart withCatalog: aCatalog createdAt: (DateAndTime year: 2017 month: 5 day: 1  hour: 2 minute: 0).
	aCreditCard := CreditCard withExpireDate: (DateAndTime year: 2017 month: 11 day: 1).
	aCart add: aBook.
	aSalesBook := LinkedList new.
	aMerchantProcessor := MerchantProcessor withSaleDo: [:anAmount :aCard | ^self error: 'NO.Stolen'].
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: (DateAndTime year: 2017 month: 5 day: 1  hour: 2 minute: 0) withSalesBook: aSalesBook.
	
	self should: [aCashier checkout: aMerchantProcessor]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'NO.Stolen'.
			self assert: aSalesBook isEmpty]
	
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/25/2017 00:25:50'!
test11CantCheckoutWithInsufficientAmount
	| aCatalog aCart aBook aCashier aCreditCard aBookCost aSalesBook aMerchantProcessor |
	aBook := #book.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	aCart := Cart withCatalog: aCatalog createdAt: (DateAndTime year: 2017 month: 5 day: 1  hour: 2 minute: 0).
	aCreditCard := CreditCard withExpireDate: (DateAndTime year: 2017 month: 11 day: 1).
	aCart add: aBook.
	aSalesBook := LinkedList new.
	aMerchantProcessor := MerchantProcessor withSaleDo: [:anAmount :aCard | ^self error: 'NO.Insufficient'].
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: (DateAndTime year: 2017 month: 5 day: 1  hour: 2 minute: 0) withSalesBook: aSalesBook.
	
	self should: [aCashier checkout: aMerchantProcessor]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'NO.Insufficient'.
			self assert: aSalesBook isEmpty]
	
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/25/2017 00:29:44'!
test12CantCreateCartForNotExistingClient
	| anInterface aClientId aDictionaryOfCarts aPassword aCatalog |
	aDictionaryOfCarts := Dictionary new.
	aCatalog := Dictionary new.
	anInterface := TusLibrosInterface withUsers: Dictionary new withCarts: aDictionaryOfCarts withCatalog: aCatalog.
	aClientId := 1.
	aPassword := 'password'.
	
	self should: [anInterface createCartWithClientId: aClientId withPassword: aPassword atDateTime: (DateAndTime year: 2017 month: 5 day: 1 hour: 2 minute: 0 )]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'No user'.
			self deny: (aDictionaryOfCarts includesKey: aClientId)]! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/25/2017 00:31:49'!
test13CantCreateCartForClientWithWrongPassword
	| anInterface aClientId aDictionaryOfCarts aPassword anUserCollection anotherPassword aCatalog |
	aDictionaryOfCarts := Dictionary new.
	aClientId := 1.
	aPassword := 'password'.
	anotherPassword := 'another_password'.
	anUserCollection := Dictionary new.
	anUserCollection at: aClientId put: aPassword.
	aCatalog := Dictionary new.
	anInterface := TusLibrosInterface withUsers: anUserCollection withCarts: aDictionaryOfCarts withCatalog: aCatalog.
	
	self should: [anInterface createCartWithClientId: aClientId withPassword: anotherPassword atDateTime: (DateAndTime year: 2017 month: 5 day: 1 hour: 2 minute: 0 )]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'No password'.
			self deny: (aDictionaryOfCarts includesKey: aClientId)]! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/25/2017 00:32:03'!
test14NewCartIsAssociatedWithClientId
	| anInterface aClientId aClientIdCartsMapping aPassword anUserCollection aCatalog aCartId |
	aClientIdCartsMapping := Dictionary new.
	aClientId := 1.
	aPassword := 'password'.
	anUserCollection := Dictionary new.
	anUserCollection at: aClientId put: aPassword.
	aCatalog := Dictionary new.
	anInterface := TusLibrosInterface withUsers: anUserCollection withCarts: aClientIdCartsMapping withCatalog: aCatalog.
	
	aCartId := anInterface createCartWithClientId: aClientId withPassword: aPassword atDateTime: (DateAndTime year: 2017 month: 5 day: 1 hour: 2 minute: 0 ).
	
	self assert: ((aClientIdCartsMapping at: aClientId) includes: aCartId).
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/26/2017 23:36:37'!
test15CantAddBooksToNonExistingCart
	| anInterface aClientId aClientIdCartsMapping aPassword anUserCollection aCartId aBook aQuantity aBookCost aCatalog |
	aClientIdCartsMapping := Dictionary new.
	aClientId := 1.
	aPassword := 'password'.
	anUserCollection := Dictionary new.
	anUserCollection at: aClientId put: aPassword.
	aBook := #ISBN000.
	aCartId := 42.
	aQuantity := 2.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	anInterface := TusLibrosInterface withUsers: anUserCollection withCarts: aClientIdCartsMapping withCatalog: aCatalog.
	
	self should: [anInterface addToCart: aCartId thisBook: aBook withQuantity: aQuantity atDateTime: (DateAndTime year: 2017 month: 5  day: 5  hour: 2  minute: 0) ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'No cart']
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 00:03:57'!
test16AddedBookIsIncludedInCartList
	| anInterface aClientId aClientIdCartsMapping aPassword anUserCollection aCartId aBook aQuantity aBookCost aCatalog |
	aClientIdCartsMapping := Dictionary new.
	aClientId := 1.
	aPassword := 'password'.
	anUserCollection := Dictionary new.
	anUserCollection at: aClientId put: aPassword.
	aBook := #ISBN000.
	aQuantity := 2.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	anInterface := TusLibrosInterface withUsers: anUserCollection withCarts: aClientIdCartsMapping withCatalog: aCatalog.
	
	aCartId := anInterface createCartWithClientId: aClientId withPassword: aPassword atDateTime: (DateAndTime year: 2017 month: 5 day: 1 hour: 2 minute: 0 ).
	anInterface addToCart: aCartId thisBook: aBook withQuantity: aQuantity atDateTime: (DateAndTime year: 2017 month: 5  day: 1  hour: 2  minute: 1) .
	
	self assert: ((anInterface listCart: aCartId atDateTime: (DateAndTime year: 2017 month: 5  day: 1  hour: 2  minute: 2)) occurrencesOf: aBook) equals: aQuantity 
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 00:04:22'!
test17CantListCartOfNonExistingCart
	| anInterface aClientId aClientIdCartsMapping aPassword anUserCollection aCartId aCatalog |
	aClientIdCartsMapping := Dictionary new.
	aClientId := 1.
	aPassword := 'password'.
	anUserCollection := Dictionary new.
	anUserCollection at: aClientId put: aPassword.
	aCartId := 42.
	aCatalog := Dictionary new.
	anInterface := TusLibrosInterface withUsers: anUserCollection withCarts: aClientIdCartsMapping withCatalog: aCatalog.
	
	self should: [anInterface listCart: aCartId atDateTime: (DateAndTime year: 2017 month: 5  day: 1  hour: 2  minute: 0)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'No cart'].
	
	

	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/25/2017 00:26:53'!
test18CantCheckoutNonExistingCart
	| anInterface aClientId aClientIdCartsMapping aPassword anUserCollection aCartId aCatalog aCreditCard|
	aClientIdCartsMapping := Dictionary new.
	aClientId := 1.
	aPassword := 'password'.
	anUserCollection := Dictionary new.
	anUserCollection at: aClientId put: aPassword.
	aCartId := 42.
	aCatalog := Dictionary new.
	aCreditCard := CreditCard withExpireDate: (DateAndTime year: 2017 month:11  day:1).
	anInterface := TusLibrosInterface withUsers: anUserCollection withCarts: aClientIdCartsMapping withCatalog: aCatalog.
	
	self should: [anInterface checkOutCart: aCartId withCreditCard: aCreditCard atDate: (DateAndTime year: 2017 month:5  day:1)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'No cart']
	
	

	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/26/2017 23:37:24'!
test19SuccessfulCheckoutRecordPurchase
	| anInterface aClientId aClientIdCartsMapping aPassword anUserCollection aCartId aCatalog aCreditCard aBook aBookCost aQuantity aBagOfBooks aListOfPurchases |
	aClientIdCartsMapping := Dictionary new.
	aClientId := 1.
	aPassword := 'password'.
	anUserCollection := Dictionary new.
	anUserCollection at: aClientId put: aPassword.
	aBook := #ISBN000.
	aBookCost := 5.
	aQuantity := 2.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	aCreditCard := CreditCard withExpireDate: (DateAndTime year: 2017 month: 11  day: 1).
	anInterface := TusLibrosInterface withUsers: anUserCollection withCarts: aClientIdCartsMapping withCatalog: aCatalog.
	aListOfPurchases := Dictionary new.
	aBagOfBooks := Bag new.
	aBagOfBooks add: aBook withOccurrences: aQuantity.
	aListOfPurchases at: 'purchases' put: aBagOfBooks.
	aListOfPurchases at: 'total_amount' put: 10.
	
	aCartId := anInterface createCartWithClientId: aClientId withPassword: aPassword atDateTime: (DateAndTime year: 2017 month: 5 day: 1 hour: 2 minute: 0 ).
	anInterface addToCart: aCartId thisBook: aBook withQuantity: aQuantity atDateTime: (DateAndTime year: 2017 month: 5  day: 1  hour: 2  minute: 1) .
	anInterface checkOutCart: aCartId withCreditCard: aCreditCard atDate: (DateAndTime year: 2017 month: 5  day: 1).	
	
	self assert: (anInterface listPurchasesWithClientId: aClientId withPassword: aPassword) equals: aListOfPurchases.
	
	

	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 23:27:49'!
test20CantListPurchasesForNonExistingClientId
	| anInterface aClientId aClientIdCartsMapping aPassword anUserCollection aCatalog |
	aClientIdCartsMapping := Dictionary new.
	aClientId := 1.
	aPassword := 'password'.
	anUserCollection := Dictionary new.
	aCatalog := Dictionary new.
	
	anInterface := TusLibrosInterface withUsers: anUserCollection withCarts: aClientIdCartsMapping withCatalog: aCatalog.
	
	self should: [anInterface listPurchasesWithClientId: aClientId withPassword: aPassword]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'No user']
	
	
	

	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/26/2017 22:43:20'!
test21CantCreateCashierWithExpiredCart
	| aCatalog aCart aCreditCard aSalesBook aMoment aMoment40MinutesLater |
	aCatalog := Dictionary new.
	aMoment := DateAndTime year: 2017 month: 6 day: 1  hour: 2 minute: 0.
	aMoment40MinutesLater := aMoment + (Duration minutes: 40).
	aCart := Cart withCatalog: aCatalog createdAt: aMoment.
	aCreditCard := CreditCard withExpireDate: (DateAndTime year: 2017 month: 11 day: 1).
	aSalesBook := LinkedList new.
	
	self should: [Cashier withCart: aCart withCreditCard: aCreditCard atDate: aMoment40MinutesLater withSalesBook: aSalesBook.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'Expired cart']
	

	

	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/26/2017 23:19:19'!
test22CantListPurchasesForClientWithWrongPassword
	| anInterface aClientId aClientIdCartsMapping aPassword anUserCollection aCatalog aWrongPassword |
	aClientIdCartsMapping := Dictionary new.
	aClientId := 1.
	aPassword := 'password'.
	aWrongPassword := 'raphael'.
	anUserCollection := Dictionary new at: aClientId put: aPassword.
	aCatalog := Dictionary new.
	
	anInterface := TusLibrosInterface withUsers: anUserCollection withCarts: aClientIdCartsMapping withCatalog: aCatalog.
	
	self should: [anInterface listPurchasesWithClientId: aClientId withPassword: aWrongPassword]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'Wrong password']
	
	
	

	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/26/2017 23:38:55'!
test23CantAddItemsToExpiredCart
	| aCatalog aMoment aMoment40MinutesLater aBook aBookCost aCartId aClientId aClientIdCartsMapping aPassword aQuantity anInterface anUserCollection |
	aMoment := DateAndTime year: 2017 month: 6 day: 1  hour: 2 minute: 0.
	aMoment40MinutesLater := aMoment + (Duration minutes: 40).	
	aClientIdCartsMapping := Dictionary new.
	aClientId := 1.
	aPassword := 'password'.
	anUserCollection := Dictionary new.
	anUserCollection at: aClientId put: aPassword.
	aBook := #ISNB000.
	aQuantity := 1.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	
	anInterface := TusLibrosInterface withUsers: anUserCollection withCarts: aClientIdCartsMapping withCatalog: aCatalog.
	aCartId := anInterface createCartWithClientId: aClientId withPassword: aPassword atDateTime: aMoment.
	
	self should: [anInterface addToCart: aCartId thisBook: aBook  withQuantity: aQuantity atDateTime: aMoment40MinutesLater ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'Expired cart']
	

	

	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/27/2017 00:01:45'!
test23CantListCartForExpiredCart
	| aCatalog aMoment aMoment40MinutesLater aBook aBookCost aCartId aClientId aClientIdCartsMapping aPassword aQuantity anInterface anUserCollection aMoment20MinutesLater |
	aMoment := DateAndTime year: 2017 month: 6 day: 1  hour: 2 minute: 0.
	aMoment20MinutesLater := aMoment + (Duration minutes: 20).
	aMoment40MinutesLater := aMoment + (Duration minutes: 40).	
	aClientIdCartsMapping := Dictionary new.
	aClientId := 1.
	aPassword := 'password'.
	anUserCollection := Dictionary new.
	anUserCollection at: aClientId put: aPassword.
	aBook := #ISNB000.
	aQuantity := 1.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	
	anInterface := TusLibrosInterface withUsers: anUserCollection withCarts: aClientIdCartsMapping withCatalog: aCatalog.
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

!Cart methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 20:33:55'!
initializeWithCatalog: aCatalog
	catalog := aCatalog.
	contents := Bag new.
	^self! !

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


!Cart class methodsFor: 'as yet unclassified' stamp: 'DIC 6/19/2017 20:28:41'!
withCatalog: aCatalog
	^self new initializeWithCatalog: aCatalog! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 23:45:08'!
withCatalog: aCatalog createdAt: aDateTime
	^self new initializeWithCatalog: aCatalog createdAt: aDateTime! !


!classDefinition: #Cashier category: #'TusLibros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'cart card currentDate salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 18:54:28'!
checkout
	| totalAmount |
	cart isEmpty ifTrue: [self error: 'NO.Empty'].
	(card isExpiredAt: currentDate) ifTrue: [self error: 'NO.Expired'].
	
	totalAmount := cart totalAmount.
	self debitAmount: totalAmount withCreditCard: card.
	salesBook addLast: totalAmount.
	
	^totalAmount! !

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
