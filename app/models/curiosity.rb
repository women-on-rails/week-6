class Curiosity < ActiveRecord::Base
  validates :category, inclusion: { in: [
                                          'Penderie',
                                          'Coffre à jouets',
                                          'Vaisselle',
                                          'Décorations',
                                          'Amis',
                                          'Bibliothèque',
                                        ]}
end
