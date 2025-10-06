# Memgraph for Lazycat Platform

## 项目简介

本项目是 [Memgraph](https://memgraph.com) 在 Lazycat 平台上的移植版本，让用户可以轻松地在 Lazycat 平台上部署和使用这个强大的开源图数据库系统。

Memgraph 是一个高性能的内存图数据库，专为动态分析环境优化。它提供实时数据处理能力、强大的图算法库（MAGE）和直观的可视化界面（Memgraph Lab）。通过本项目，您可以在 Lazycat 平台上一键部署 Memgraph，享受便捷的图数据库服务。

## 主要功能

- 🚀 高性能内存图数据库，支持实时数据处理
- 🔍 完整的 Cypher 查询语言支持
- 🧮 内置 MAGE 图算法库，提供丰富的图分析算法
- 📊 Memgraph Lab 可视化界面，直观管理和查询图数据
- ⚡ 支持流式数据处理和实时分析
- 🔗 与 Neo4j 生态系统兼容
- 💾 灵活的数据持久化选项
- 🌐 支持 Bolt 协议和 HTTP API

## 致谢

本项目基于开源社区的杰出贡献：

- **Memgraph 团队**：感谢 [Memgraph](https://github.com/memgraph/memgraph) 项目团队开发和维护这个优秀的开源图数据库平台
- **开源社区**：感谢所有为 Memgraph 项目做出贡献的开发者和社区成员
- **Lazycat 平台**：提供便捷的应用部署和管理能力

## 版权说明

- 本仓库的打包配置文件采用 [Business Source License 1.1](LICENSE)
- Memgraph 软件本身采用 [Business Source License 1.1 和 Memgraph Enterprise License](https://github.com/memgraph/memgraph/blob/master/LICENSE)

## 快速开始

### 导入测试数据

本项目提供了 `test-data.cypher` 测试数据文件，包含用户、产品、公司、位置和标签等节点及其关系。

**通过 Memgraph Lab 导入：**

1. 在浏览器中打开 Memgraph Lab（访问地址：`https://memgraph.${LAZYCAT_BOX_NAME}.heiyu.space`）
2. 在查询编辑器中，将 `test-data.cypher` 文件的内容复制粘贴进去
3. 点击运行按钮执行所有语句

### 示例查询

导入测试数据后，可以尝试以下查询：

#### 1. 查看所有用户
```cypher
MATCH (u:User)
RETURN u.name, u.email, u.age
ORDER BY u.age DESC;
```

#### 2. 查找用户的购买记录
```cypher
MATCH (u:User {name: 'Alice Wang'})-[:PURCHASED]->(prod:Product)
RETURN u.name, prod.name, prod.price;
```

#### 3. 查找用户的关注关系
```cypher
MATCH (u1:User)-[:FOLLOWS]->(u2:User)
RETURN u1.name AS follower, u2.name AS following;
```

#### 4. 查找在同一公司工作的用户
```cypher
MATCH (u:User)-[:WORKS_AT]->(c:Company {name: 'TechCorp'})
RETURN u.name, u.age, c.name
ORDER BY u.age DESC;
```

#### 5. 推荐系统：基于共同兴趣推荐用户
```cypher
MATCH (u1:User {name: 'Alice Wang'})-[:INTERESTED_IN]->(t:Tag)<-[:INTERESTED_IN]-(u2:User)
WHERE u1 <> u2
RETURN u2.name, COUNT(t) AS common_interests, COLLECT(t.name) AS tags
ORDER BY common_interests DESC;
```

#### 6. 查找二度关系：朋友的朋友
```cypher
MATCH (u:User {name: 'Alice Wang'})-[:FOLLOWS]->()-[:FOLLOWS]->(friend_of_friend:User)
WHERE friend_of_friend <> u
RETURN DISTINCT friend_of_friend.name, friend_of_friend.email;
```

#### 7. 分析产品标签的热度
```cypher
MATCH (p:Product)-[:TAGGED_WITH]->(t:Tag)
RETURN t.name, COUNT(p) AS product_count
ORDER BY product_count DESC;
```

#### 8. 查找购买特定产品的用户的其他购买
```cypher
MATCH (u:User)-[:PURCHASED]->(:Product {name: 'Laptop Pro 15'})
MATCH (u)-[:PURCHASED]->(other:Product)
WHERE other.name <> 'Laptop Pro 15'
RETURN other.name, COUNT(DISTINCT u) AS buyers
ORDER BY buyers DESC;
```

#### 9. 计算用户购买的产品数量
```cypher
MATCH (u:User)-[:PURCHASED]->(p:Product)
RETURN u.name, COUNT(p) AS product_count
ORDER BY product_count DESC;
```

#### 10. 查找公司所在城市及员工
```cypher
MATCH (c:Company)-[:LOCATED_IN]->(l:Location)
MATCH (u:User)-[:WORKS_AT]->(c)
RETURN c.name, l.city, COUNT(u) AS employee_count
ORDER BY employee_count DESC;
```

## 相关链接

- Memgraph 官方网站：https://memgraph.com
- Memgraph 源代码：https://github.com/memgraph/memgraph
- Memgraph 官方文档：https://memgraph.com/docs
- Lazycat 平台：https://lazycat.cloud
