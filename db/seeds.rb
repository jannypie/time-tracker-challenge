# company = Company.create! name: 'CoverMyDrugs', address1: '1 Beeranova Pl.'
# company = Company.create! name: 'CoverMyBuns', address1: '2 Beeranova Pl.'
company = Company.create! name: 'CoverMyEyes', address1: '3 Beeranova Pl.'

# project = company.projects.create! name: 'Motron-motron'
# project = company.projects.create! name: 'Relieve'
project = company.projects.create! name: 'Dadville'

# company.projects.create! name: 'Automatic node free-er'
# company.projects.create! name: "MRI (Mike's Ruby Interpreter)"
# company.projects.create! name: 'Convert RDBMS to Redis'
# company.projects.create! name: 'Add message bus to Claymore'
# company.projects.create! name: 'Contrive a use ØMQ'
# company.projects.create! name: 'Nuke Gluster from orbit'

development    = company.tasks.create name: 'Development'
design         = company.tasks.create name: 'Design'
qa             = company.tasks.create name: 'QA'
infrastructure = company.tasks.create name: 'Infrastructure'
other          = company.tasks.create name: 'Tetris'

user = User.first()

5.times do
  time_entry = TimeEntry.create! user: user, task: development, project: project
end