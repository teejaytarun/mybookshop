namespace my.bookshop;
using { User, Country, managed, cuid } from '@sap/cds/common';

entity Books : managed{
  key ID : Integer;
  title  : localized String;
  author : Association to Authors;
  stock  : Integer;
}

entity Authors : managed{
  key ID : Integer;
  name   : String;
  books  : Association to many Books on books.author = $self;
}

entity Orders : managed {
  key ID  : UUID;
  book    : Association to Books;
  country : Country;
  amount  : Integer;
}

////////////////////////////////////////////////////////////////////////////
//
//	Books Lists
//
annotate Books with @(
	UI: {
		Identification: [{Value:title}],
	  SelectionFields: [ ID, author_ID ],
		LineItem: [
			{Value: ID},
			{Value: title},
			{Value: author.name, Label:'Author'},
			{Value: stock}
		]
	}
) {
	author @ValueList.entity:'Authors';
};

////////////////////////////////////////////////////////////////////////////
//
//	Books Details
//
annotate Books with @(
	UI: {
  	HeaderInfo: {
  		TypeName: 'Book',
  		TypeNamePlural: 'Books',
  		Title: {Value: title}
  	},
	}
);



////////////////////////////////////////////////////////////////////////////
//
//	Books Elements
//
annotate Books with {
	ID @title:'ID' @UI.HiddenFilter;
	title @title:'Title';
	author @title:'Author ID';
	stock @title:'Stock';
}

////////////////////////////////////////////////////////////////////////////
//
//	Author Lists
//
annotate Authors with @(
	UI: {
		Identification: [{Value: name}],
	  SelectionFields: [ ID, name ],
		LineItem: [
			{Value: ID},
			{Value: name}
		]
	}
);

////////////////////////////////////////////////////////////////////////////
//
//	Author Details
//
annotate Authors with @(
	UI: {
  	HeaderInfo: {
  		TypeName: 'Author',
  		TypeNamePlural: 'Authors',
  		Title: {Value: name}
  	},
	}
);

////////////////////////////////////////////////////////////////////////////
//
//	Authors Elements
//
annotate my.Authors with {
	ID @title:'{i18n>ID}' @UI.HiddenFilter;
	name @title:'{i18n>AuthorName}';
}


////////////////////////////////////////////////////////////////////////////
//
//	Authors Elements
//
annotate Authors with {
	ID @title:'ID' @UI.HiddenFilter;
	name @title:'Author Name';
}

////////////////////////////////////////////////////////////////////////////
//
//	Books Object Page
//
annotate Books with @(
	UI: {
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: 'General', Target: '@UI.FieldGroup#General'},
			{$Type: 'UI.ReferenceFacet', Label: 'Details', Target: '@UI.FieldGroup#Details'}
		],
		FieldGroup#General: {
			Data: [
				{Value: title},
				{Value: author_ID}
			]
		},
		FieldGroup#Details: {
			Data: [
				{Value: stock}
			]
		}
	}
);

