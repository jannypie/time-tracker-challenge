company1 = Company.create! name: 'CoverMyDrugs', address1: '1 Beeranova Pl.'
company2 = Company.create! name: 'CoverMyBuns', address1: '2 Beeranova Pl.'
company3 = Company.create! name: 'CoverMyEyes', address1: '3 Beeranova Pl.'

project1 = company1.projects.create! name: 'Motron-motron'
project2 = company2.projects.create! name: 'Relieve'
project3 = company3.projects.create! name: 'Dadville'

company1.projects.create! name: 'Automatic node free-er'
company1.projects.create! name: "MRI (Mike's Ruby Interpreter)"
company2.projects.create! name: 'Convert RDBMS to Redis'
company2.projects.create! name: 'Add message bus to Claymore'
company3.projects.create! name: 'Contrive a use ØMQ'
company3.projects.create! name: 'Nuke Gluster from orbit'

[company1,company2,company3].each do |company|
  development    = company.tasks.create name: 'Development'
  design         = company.tasks.create name: 'Design'
  qa             = company.tasks.create name: 'QA'
  infrastructure = company.tasks.create name: 'Infrastructure'
  other          = company.tasks.create name: 'Tetris'
end

user = User.create! email: 'user@test.com', password: 'supersecret'

user.time_entries.create! project: project1, task: company1.tasks.first, duration: 3600000
user.time_entries.create! project: project2, task: company2.tasks.last, duration: 2.88e+7
user.time_entries.create! project: project1, task: company1.tasks.first, duration: 1.26e+7
user.time_entries.create! project: project3, task: company3.tasks[1], duration: 3600000
