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

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 19:28:16'!
test06CantCheckoutWithEmptyCart
| aCatalog aCart aCashier aCreditCard aSalesBook aMerchantProcessor |
	aCatalog := Set new.
	aCart := Cart withCatalog: aCatalog.
	aCreditCard := CreditCard withExpireDate: (Date year: 2017 month: 11 day: 1).
	aSalesBook := LinkedList new.
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: (Date year: 2017 month: 5 day: 1) withSalesBook: aSalesBook.
	aMerchantProcessor := MerchantProcessor withSaleDo: [:anAmount :aCard | ^self].
	
	self should: [aCashier checkout: aMerchantProcessor]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'NO.Empty'.
			self assert: aSalesBook isEmpty]
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 19:28:34'!
test07CantCheckoutWithExpiredCreditCard
| aCatalog aCart aBook aBookCost aCashier anExpiredCreditCard aSalesBook aMerchantProcessor |
	aBook := #book.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	aCart := Cart withCatalog: aCatalog.
	anExpiredCreditCard := CreditCard withExpireDate: (Date year: 2017 month: 5 day: 1).
	aCart add: aBook.
	aSalesBook := LinkedList new.
	aCashier := Cashier withCart: aCart withCreditCard: anExpiredCreditCard atDate: (Date year: 2017 month: 8 day: 1) withSalesBook: aSalesBook.
	aMerchantProcessor := MerchantProcessor withSaleDo: [:anAmount :aCard | ^self].
	
	self should: [aCashier checkout: aMerchantProcessor]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'NO.Expired'.
			self assert: aSalesBook isEmpty]
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 19:25:38'!
test08SuccessfulCheckoutReturnsTotalValue
	| aCatalog aCart aBook aCashier aCreditCard aBookCost aSalesBook checkoutAmount aMerchantProcessor |
	aBook := #book.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	aCart := Cart withCatalog: aCatalog.
	aCreditCard := CreditCard withExpireDate: (Date year: 2017 month: 11 day: 1).
	aCart add: aBook.
	aSalesBook := LinkedList new.
	aMerchantProcessor := MerchantProcessor withSaleDo: [:anAmount :aCard | ^self].
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: (Date year: 2017 month: 5 day: 1) withSalesBook: aSalesBook.
	
	checkoutAmount := aCashier checkout: aMerchantProcessor .
	
	self assert: checkoutAmount equals: aBookCost.
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 19:26:39'!
test09SuccessfulCheckoutRecordsLastSale
	| aCatalog aCart aBook aCashier aCreditCard aBookCost aSalesBook checkoutAmount aMerchantProcessor |
	aBook := #book.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	aCart := Cart withCatalog: aCatalog.
	aCreditCard := CreditCard withExpireDate: (Date year: 2017 month: 11 day: 1).
	aCart add: aBook.
	aSalesBook := LinkedList new.
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: (Date year: 2017 month: 5 day: 1) withSalesBook: aSalesBook.
	aMerchantProcessor := MerchantProcessor withSaleDo: [:anAmount :aCard | ^self].
	checkoutAmount := aCashier checkout: aMerchantProcessor.
	
	self assert: aSalesBook last = checkoutAmount. 
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 19:24:01'!
test10CantCheckoutWithStolenCreditCard
	| aCatalog aCart aBook aCashier aCreditCard aBookCost aSalesBook aMerchantProcessor |
	aBook := #book.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	aCart := Cart withCatalog: aCatalog.
	aCreditCard := CreditCard withExpireDate: (Date year: 2017 month: 11 day: 1).
	aCart add: aBook.
	aSalesBook := LinkedList new.
	aMerchantProcessor := MerchantProcessor withSaleDo: [:anAmount :aCard | ^self error: 'NO.Stolen'].
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: (Date year: 2017 month: 5 day: 1) withSalesBook: aSalesBook.
	
	self should: [aCashier checkout: aMerchantProcessor]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'NO.Stolen'.
			self assert: aSalesBook isEmpty]
	
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 19:32:59'!
test11CantCheckoutWithInsufficientAmount
	| aCatalog aCart aBook aCashier aCreditCard aBookCost aSalesBook aMerchantProcessor |
	aBook := #book.
	aBookCost := 5.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: aBookCost.
	aCart := Cart withCatalog: aCatalog.
	aCreditCard := CreditCard withExpireDate: (Date year: 2017 month: 11 day: 1).
	aCart add: aBook.
	aSalesBook := LinkedList new.
	aMerchantProcessor := MerchantProcessor withSaleDo: [:anAmount :aCard | ^self error: 'NO.Insufficient'].
	aCashier := Cashier withCart: aCart withCreditCard: aCreditCard atDate: (Date year: 2017 month: 5 day: 1) withSalesBook: aSalesBook.
	
	self should: [aCashier checkout: aMerchantProcessor]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'NO.Insufficient'.
			self assert: aSalesBook isEmpty]
	
	
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 20:52:05'!
test12CantCreateCartForNotExistingClient
	| anInterface aClientId aDictionaryOfCarts aPassword aCatalog |
	aDictionaryOfCarts := Dictionary new.
	aCatalog := Dictionary new.
	anInterface := TusLibrosInterface withUsers: Dictionary new withCarts: aDictionaryOfCarts withCatalog: aCatalog.
	aClientId := 1.
	aPassword := 'password'.
	
	self should: [anInterface createCartWithClientId: aClientId withPassword: aPassword]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'No user'.
			self deny: (aDictionaryOfCarts includesKey: aClientId)]! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 20:51:41'!
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
	
	self should: [anInterface createCartWithClientId: aClientId withPassword: anotherPassword]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'No password'.
			self deny: (aDictionaryOfCarts includesKey: aClientId)]! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 20:53:11'!
test14NewCartIsAssociatedWithClientId
	| anInterface aClientId aClientIdCartsMapping aPassword anUserCollection aCart aCatalog |
	aClientIdCartsMapping := Dictionary new.
	aClientId := 1.
	aPassword := 'password'.
	anUserCollection := Dictionary new.
	anUserCollection at: aClientId put: aPassword.
	aCatalog := Dictionary new.
	anInterface := TusLibrosInterface withUsers: anUserCollection withCarts: aClientIdCartsMapping withCatalog: aCatalog.
	
	aCart := anInterface createCartWithClientId: aClientId withPassword: aPassword.
	
	self assert: ((aClientIdCartsMapping at: aClientId) includes: aCart).
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 20:53:45'!
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
	
	self should: [anInterface addToCart: aCartId thisBook: aBook withQuantity: aQuantity]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'No cart']
	
	! !


!classDefinition: #Cart category: #'TusLibros-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'catalog contents'
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

!Cashier class methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 18:52:39'!
withCart: aCart withCreditCard: aCreditCard atDate: aDate withSalesBook: aSalesBook.
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
	instanceVariableNames: 'users carts catalog cartMapping'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 20:56:50'!
addToCart: aCartId thisBook: aBook withQuantity: aQuantity 
	cartMapping at: aCartId ifAbsent: [^self error: 'No cart']! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 20:36:04'!
createCartWithClientId: aClientId withPassword: aPassword 
	| password newCart |
	password := users at: aClientId ifAbsent: [^self error: 'No user'].
	password = aPassword ifFalse: [^self error: 'No password'].
	
	newCart := Cart withCatalog: catalog.

	(carts at: aClientId ifAbsentPut: Set new) add: newCart.
	^newCart
	! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 20:57:26'!
withUsers: anUserCollection withCarts: aCartCollection withCatalog: aCatalog
	users := anUserCollection.
	carts := aCartCollection.
	catalog := aCatalog.
	cartMapping := Dictionary new.
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: #'TusLibros-Solution'!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'as yet unclassified' stamp: 'DIC 6/24/2017 20:49:24'!
withUsers: aUserCollection withCarts: aCartCollection withCatalog: aCatalog
	^self new withUsers: aUserCollection withCarts: aCartCollection withCatalog: aCatalog! !
