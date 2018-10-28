
exports.up = function(knex, Promise) {
  return knex.schema.createTable('ping', function (t) {
    t.increments('id').primary()
    t.string('origin').notNullable()
    t.string('destination').notNullable()
    t.decimal('latency', 12,8).notNullable()
    t.timestamps(false, true)
  })
};

exports.down = function(knex, Promise) {
  return knex.schema.dropTableIfExists('ping')
};
