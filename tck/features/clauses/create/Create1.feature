#
# Copyright (c) 2015-2019 "Neo Technology,"
# Network Engine for Objects in Lund AB [http://neotechnology.com]
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Attribution Notice under the terms of the Apache License 2.0
#
# This work was created by the collective efforts of the openCypher community.
# Without limiting the terms of Section 6, any Derivative Work that is not
# approved by the public consensus process of the openCypher Implementers Group
# should not be described as “Cypher” (and Cypher® is a registered trademark of
# Neo4j Inc.) or as "openCypher". Extensions by implementers or prototypes or
# proposals for change that have been documented or implemented should only be
# described as "implementation extensions to Cypher" or as "proposed changes to
# Cypher that are not yet approved by the openCypher community".
#

#encoding: utf-8

Feature: Create1 - Creating nodes

  Scenario: [1] Creating a single node
    Given any graph
    When executing query:
      """
      CREATE ()
      """
    Then the result should be empty
    And the side effects should be:
      | +nodes | 1 |

  Scenario: [2] Creating two nodes
    Given any graph
    When executing query:
      """
      CREATE (), ()
      """
    Then the result should be empty
    And the side effects should be:
      | +nodes | 2 |

  Scenario: [3] Creating two nodes and a relationship
    Given any graph
    When executing query:
      """
      CREATE ()-[:TYPE]->()
      """
    Then the result should be empty
    And the side effects should be:
      | +nodes         | 2 |
      | +relationships | 1 |

  Scenario: [4] Creating a single node with a label
    Given any graph
    When executing query:
      """
      CREATE (:Label)
      """
    Then the result should be empty
    And the side effects should be:
      | +nodes  | 1 |
      | +labels | 1 |

  Scenario: [5] Creating a single node with multiple labels
    Given any graph
    When executing query:
      """
      CREATE (:A:B:C:D)
      """
    Then the result should be empty
    And the side effects should be:
      | +nodes  | 1 |
      | +labels | 4 |

  Scenario: [6] Creating a single node with a property
    Given any graph
    When executing query:
      """
      CREATE ({created: true})
      """
    Then the result should be empty
    And the side effects should be:
      | +nodes      | 1 |
      | +properties | 1 |

  Scenario: [7] Creating a single node with a property and returning it
    Given any graph
    When executing query:
      """
      CREATE (n {name: 'foo'})
      RETURN n.name AS p
      """
    Then the result should be:
      | p     |
      | 'foo' |
    And the side effects should be:
      | +nodes      | 1 |
      | +properties | 1 |

  Scenario: [8] Creating a single node with two properties
    Given any graph
    When executing query:
      """
      CREATE (n {id: 12, name: 'foo'})
      """
    Then the result should be empty
    And the side effects should be:
      | +nodes      | 1 |
      | +properties | 2 |

  Scenario: [9] Creating a single node with two properties and returning them
    Given any graph
    When executing query:
      """
      CREATE (n {id: 12, name: 'foo'})
      RETURN n.id AS id, n.name AS p
      """
    Then the result should be:
      | id | p     |
      | 12 | 'foo' |
    And the side effects should be:
      | +nodes      | 1 |
      | +properties | 2 |

  Scenario: [10] Creating a single node with null properties should not return those properties
    Given any graph
    When executing query:
      """
      CREATE (n {id: 12, name: null})
      RETURN n.id AS id
      """
    Then the result should be:
      | id |
      | 12 |
    And the side effects should be:
      | +nodes      | 1 |
      | +properties | 1 |