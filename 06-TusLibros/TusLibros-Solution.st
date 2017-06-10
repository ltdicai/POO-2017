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


!classDefinition: #Cart category: #'TusLibros-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'empty contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cart methodsFor: 'adding' stamp: 'DIC 6/10/2017 18:11:07'!
addItem: anItem withQuantity: aInteger 
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
