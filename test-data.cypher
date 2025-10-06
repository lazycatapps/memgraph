// Test Data for Memgraph Knowledge Graph
// This file contains sample data to demonstrate the graph structure

// Create Users
CREATE (:User {id: 'user1', name: 'Alice Wang', email: 'alice@example.com', age: 28, created_at: datetime()});
CREATE (:User {id: 'user2', name: 'Bob Chen', email: 'bob@example.com', age: 32, created_at: datetime()});
CREATE (:User {id: 'user3', name: 'Carol Zhang', email: 'carol@example.com', age: 25, created_at: datetime()});
CREATE (:User {id: 'user4', name: 'David Li', email: 'david@example.com', age: 35, created_at: datetime()});
CREATE (:User {id: 'user5', name: 'Eve Liu', email: 'eve@example.com', age: 29, created_at: datetime()});

// Create Products
CREATE (:Product {id: 'prod1', name: 'Laptop Pro 15', category: 'Electronics', price: 1299.99, stock: 50});
CREATE (:Product {id: 'prod2', name: 'Wireless Mouse', category: 'Electronics', price: 29.99, stock: 200});
CREATE (:Product {id: 'prod3', name: 'Mechanical Keyboard', category: 'Electronics', price: 89.99, stock: 150});
CREATE (:Product {id: 'prod4', name: 'USB-C Cable', category: 'Accessories', price: 12.99, stock: 500});
CREATE (:Product {id: 'prod5', name: 'Monitor 27"', category: 'Electronics', price: 399.99, stock: 80});
CREATE (:Product {id: 'prod6', name: 'Headphones', category: 'Audio', price: 159.99, stock: 120});

// Create Companies
CREATE (:Company {id: 'comp1', name: 'TechCorp', industry: 'Software', employees: 5000, founded: 2010});
CREATE (:Company {id: 'comp2', name: 'DataSys Inc', industry: 'Data Analytics', employees: 1200, founded: 2015});
CREATE (:Company {id: 'comp3', name: 'CloudNet', industry: 'Cloud Services', employees: 3000, founded: 2012});

// Create Locations
CREATE (:Location {id: 'loc1', city: 'Beijing', country: 'China', lat: 39.9042, lon: 116.4074});
CREATE (:Location {id: 'loc2', city: 'Shanghai', country: 'China', lat: 31.2304, lon: 121.4737});
CREATE (:Location {id: 'loc3', city: 'Shenzhen', country: 'China', lat: 22.5431, lon: 114.0579});

// Create Tags
CREATE (:Tag {name: 'AI', category: 'Technology'});
CREATE (:Tag {name: 'Cloud', category: 'Technology'});
CREATE (:Tag {name: 'Database', category: 'Technology'});
CREATE (:Tag {name: 'Gaming', category: 'Entertainment'});
CREATE (:Tag {name: 'Productivity', category: 'Work'});

// Create Relationships - Users follow each other
MATCH (u1:User {id: 'user1'}), (u2:User {id: 'user2'}) CREATE (u1)-[:FOLLOWS]->(u2);
MATCH (u1:User {id: 'user1'}), (u3:User {id: 'user3'}) CREATE (u1)-[:FOLLOWS]->(u3);
MATCH (u2:User {id: 'user2'}), (u4:User {id: 'user4'}) CREATE (u2)-[:FOLLOWS]->(u4);
MATCH (u3:User {id: 'user3'}), (u1:User {id: 'user1'}) CREATE (u3)-[:FOLLOWS]->(u1);
MATCH (u4:User {id: 'user4'}), (u5:User {id: 'user5'}) CREATE (u4)-[:FOLLOWS]->(u5);
MATCH (u5:User {id: 'user5'}), (u2:User {id: 'user2'}) CREATE (u5)-[:FOLLOWS]->(u2);

// Create Relationships - Users purchase products
MATCH (u1:User {id: 'user1'}), (p1:Product {id: 'prod1'}) CREATE (u1)-[:PURCHASED]->(p1);
MATCH (u1:User {id: 'user1'}), (p2:Product {id: 'prod2'}) CREATE (u1)-[:PURCHASED]->(p2);
MATCH (u2:User {id: 'user2'}), (p3:Product {id: 'prod3'}) CREATE (u2)-[:PURCHASED]->(p3);
MATCH (u3:User {id: 'user3'}), (p5:Product {id: 'prod5'}) CREATE (u3)-[:PURCHASED]->(p5);
MATCH (u4:User {id: 'user4'}), (p6:Product {id: 'prod6'}) CREATE (u4)-[:PURCHASED]->(p6);
MATCH (u5:User {id: 'user5'}), (p4:Product {id: 'prod4'}) CREATE (u5)-[:PURCHASED]->(p4);

// Create Relationships - Users work at companies
MATCH (u1:User {id: 'user1'}), (c1:Company {id: 'comp1'}) CREATE (u1)-[:WORKS_AT]->(c1);
MATCH (u2:User {id: 'user2'}), (c2:Company {id: 'comp2'}) CREATE (u2)-[:WORKS_AT]->(c2);
MATCH (u3:User {id: 'user3'}), (c1:Company {id: 'comp1'}) CREATE (u3)-[:WORKS_AT]->(c1);
MATCH (u4:User {id: 'user4'}), (c3:Company {id: 'comp3'}) CREATE (u4)-[:WORKS_AT]->(c3);
MATCH (u5:User {id: 'user5'}), (c2:Company {id: 'comp2'}) CREATE (u5)-[:WORKS_AT]->(c2);

// Create Relationships - Companies located in cities
MATCH (c1:Company {id: 'comp1'}), (l1:Location {id: 'loc1'}) CREATE (c1)-[:LOCATED_IN]->(l1);
MATCH (c2:Company {id: 'comp2'}), (l2:Location {id: 'loc2'}) CREATE (c2)-[:LOCATED_IN]->(l2);
MATCH (c3:Company {id: 'comp3'}), (l3:Location {id: 'loc3'}) CREATE (c3)-[:LOCATED_IN]->(l3);

// Create Relationships - Products tagged
MATCH (p1:Product {id: 'prod1'}), (t:Tag {name: 'Productivity'}) CREATE (p1)-[:TAGGED_WITH]->(t);
MATCH (p1:Product {id: 'prod1'}), (t:Tag {name: 'AI'}) CREATE (p1)-[:TAGGED_WITH]->(t);
MATCH (p3:Product {id: 'prod3'}), (t:Tag {name: 'Gaming'}) CREATE (p3)-[:TAGGED_WITH]->(t);
MATCH (p3:Product {id: 'prod3'}), (t:Tag {name: 'Productivity'}) CREATE (p3)-[:TAGGED_WITH]->(t);
MATCH (p5:Product {id: 'prod5'}), (t:Tag {name: 'Productivity'}) CREATE (p5)-[:TAGGED_WITH]->(t);
MATCH (p6:Product {id: 'prod6'}), (t:Tag {name: 'Gaming'}) CREATE (p6)-[:TAGGED_WITH]->(t);

// Create Relationships - Users interested in tags
MATCH (u1:User {id: 'user1'}), (t:Tag {name: 'AI'}) CREATE (u1)-[:INTERESTED_IN]->(t);
MATCH (u1:User {id: 'user1'}), (t:Tag {name: 'Database'}) CREATE (u1)-[:INTERESTED_IN]->(t);
MATCH (u2:User {id: 'user2'}), (t:Tag {name: 'Database'}) CREATE (u2)-[:INTERESTED_IN]->(t);
MATCH (u2:User {id: 'user2'}), (t:Tag {name: 'Cloud'}) CREATE (u2)-[:INTERESTED_IN]->(t);
MATCH (u3:User {id: 'user3'}), (t:Tag {name: 'Productivity'}) CREATE (u3)-[:INTERESTED_IN]->(t);
MATCH (u4:User {id: 'user4'}), (t:Tag {name: 'Cloud'}) CREATE (u4)-[:INTERESTED_IN]->(t);
MATCH (u5:User {id: 'user5'}), (t:Tag {name: 'Gaming'}) CREATE (u5)-[:INTERESTED_IN]->(t);
