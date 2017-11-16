<h2>DSCache
  <small class="text-muted">
    <a href="https://github.com/dapphub/ds-cache"><span class="fa fa-github"></span></a>
  </small>
</h2>

_DSValue with expiry_
  
Authorized users can set and unset a value and a time at which the value will 
expire. Anyone can read the value and check freshness.

### Actions

#### `peek`
return the stored value along with boolean `true` if the value is still valid 
and `false` if not.

#### `read`
return either the stored value or an exception if expired

#### `prod`
set a value and expiry (requires auth)
