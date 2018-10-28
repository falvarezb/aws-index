// Update with your config settings.

module.exports = {

  development: {
    client: 'mysql',
    connection: {
      database: 'aws-index',
      user:     'admin',
      password: 'admin',
      port: 3406
    },
    pool: {
      min: 2,
      max: 10
    },
    migrations: {
      tableName: 'knex_migrations'
    }
  },

  production: {
    client: 'mysql',
    connection: {
      host: process.env.DB_HOST,
      database: 'aws_index',
      user:     process.env.DB_USER,
      password: process.env.DB_PWD,
      port: 3306
    },
    pool: {
      min: 2,
      max: 10
    },
    migrations: {
      tableName: 'knex_migrations'
    }
  }

};
