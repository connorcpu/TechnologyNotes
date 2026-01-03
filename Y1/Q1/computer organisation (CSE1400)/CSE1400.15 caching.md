you cannot influnce it, it's done per page (4kb)   
where does one put the data in cache    
- 'mapping'
   - static: 
   - direct: figure out some key as part of the key, put it in that spot, now you can tell straight away if it's in the cache or not; top 5 bits are tag, 7 bit for what page, 4 bits for index into page
   - dynamic
   - (fully) associative cache, you need the full tag because how to know where the page is that you are looking for 
   - mixed
