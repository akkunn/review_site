class Language < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' },
    { id: 1, name: 'C言語' }, { id: 2, name: 'C++' }, { id: 3, name: 'Java' },
    { id: 4, name: 'C#' }, { id: 5, name: 'Java Script' }, { id: 6, name: 'PHP' },
    { id: 7, name: 'Ruby' }, { id: 8, name: 'Python' }, { id: 9, name: 'Go言語' },
    { id: 10, name: 'Visual Basic' }, { id: 11, name: 'R言語' }, { id: 12, name: 'Swift' },
    { id: 13, name: 'Kotlin' }, { id: 14, name: 'Objective-C' }, { id: 15, name: 'Type Script' },
    { id: 16, name: 'VB Script' }, { id: 17, name: 'BASIC' },
    { id: 18, name: 'Google Apps Script' },
    { id: 19, name: 'Haskell' }, { id: 20, name: 'Scala' }, { id: 21, name: 'Groovy' },
    { id: 22, name: 'Delphi' }, { id: 23, name: 'Dart' }, { id: 24, name: 'D言語' },
    { id: 25, name: 'Perl' }, { id: 26, name: 'COBOL' }, { id: 27, name: 'SQL' },
    { id: 28, name: 'FORTRAN' }, { id: 29, name: 'MATLAB' }, { id: 30, name: 'Scratch' },
  ]
  include ActiveHash::Associations
  has_many :schools
end
