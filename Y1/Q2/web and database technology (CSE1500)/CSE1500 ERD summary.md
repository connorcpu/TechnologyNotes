


shape | object
------|--------
square | entity
circle | attribute
diamond | relationship 
double square | weak entity
double diamond | identifying relationship
composite attributes | cricle with more circles attached (address made up from city and street)
derived attribute | dotted circle (like age, which is derived from the birthdate)
double circle | multi-value attribute (like multiple phone numbers)

- on line to relationship write what role the entity plays E.G. customer _places_ order 
- on line to relationship write cardinality constraint like 1 or N (on both sides)
- double relationship line means total participation, which means every instance of the entity participates in the relation
   - since every uni must have a dean that is a professor, uni has a double line to the dean relationship but professor a single line
- (0, 1) means 0 to 1 in relationship cardinality
- logical: 
   - tablename(col1name, col2name)
   - tablename(col1name -> foreignTable(foreignColName)) for a foreignkey
   - subType(id->headType(id), subTypeAttribut)
   - list -> (listName, userName) for weak entity list with identifying relationship to user
   - UNDERLINE PRIMARY KEY by prefixing with underscore
