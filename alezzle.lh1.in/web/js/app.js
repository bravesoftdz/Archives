var Track = React.createClass({
    render : function(){
      return (
        <tr>
            <td className="fld-artist">{this.props.artist}</td>
            <td className="fld-track">{this.props.track}</td>
            <td className="fld-genre">{this.props.genre}</td>
            <td className="fld-year">{this.props.year}</td>
        </tr>
      );
    }
});
  
var TrackList = React.createClass({
    clickHandler: function(e){
        e.preventDefault();
        this.props.updateSorting(e.target.getAttribute("data-sortfield"), e.target.getAttribute("data-direction"));
    },
    
    render : function(){  
        var tracks = this.props.tracks.map(function(p){
            return (
                <Track key={p.id} artist={p.artist} track={p.track} genre={p.genre} year={p.year} />     
            );
        });

        var thData = [
            {title: 'Исполнитель' , className : 'fld-artist', sortField : 'a.title'},
            {title: 'Песня' , className : 'fld-track', sortField : 't.title'},
            {title: 'Жанр' , className : 'fld-genre', sortField : 'g.name'},
            {title: 'Год' , className : 'fld-year', sortField : 't.year'},
        ];
        
        var tableHead = thData.map(function(p){
            
            var upButton = <a className="order-button-up" href="#" onClick={this.clickHandler} data-sortfield={p.sortField} data-direction="asc"></a>;
            if (p.sortField == this.props.sort && this.props.direction=="asc") {
                upButton = <span className="order-button-up order-button-up-selected" ></span>;
            }    
            
            var downButton = <a className="order-button-down" href="#" onClick={this.clickHandler} data-sortfield={p.sortField} data-direction="desc"></a>;
            if (p.sortField == this.props.sort && this.props.direction=="desc") {
                downButton = <span className="order-button-down order-button-down-selected" ></span>;
            }    
            
            return (
                <th className={p.className}>
                    {p.title}
                    <div className="order-buttons">
                        {upButton}<br />
                        {downButton}
                    </div>
                </th>
            );    
        }.bind(this));

        return(
            <table><tbody>
                <tr>
                {tableHead}    
                </tr>
                {tracks}
            </tbody></table>
        );
    }
});

var LimitsNav = React.createClass({
    clickHandler : function(e){
        e.preventDefault();
        this.props.updateLimit(e.target.innerHTML);
    },
    
    render : function(){
        
        var limits = [10, 25, 50, 100];
        var btnLimits = limits.map(function(p){
            if(p==this.props.limit) {
                return (<span className="counter-button counter-selected">{p}</span>);
            }
                else return(<a href="#" className="counter-button" onClick={this.clickHandler}>{p}</a>);
        }.bind(this));    
        
        return(  
            <div className="countrer-container">
            {btnLimits}
            </div>
        );
    } 
});

var PageNav = React.createClass({
    clickHandler : function(e){
        e.preventDefault();
        this.props.updatePage(e.target.getAttribute("data-page"));
    },
    
    render : function(){ 
        var Page = parseInt(this.props.page);
        var NextPage = Page+1;
        var PrivPage = Page-1;
        var TotalPageCount = parseInt(this.props.pcount); 
        var DisplayPageCount = 10;
        var HalfCount = DisplayPageCount / 2; 
        var BeforePageCount = HalfCount;
        var AfterPageCount = HalfCount; 
         
        if ((Page + HalfCount) > TotalPageCount){
            AfterPageCount = TotalPageCount - Page;
            BeforePageCount = 2 * HalfCount - AfterPageCount;
        }
        if ((Page - HalfCount) <= 0){
            if ((Page + AfterPageCount) < TotalPageCount)
                AfterPageCount = AfterPageCount - (Page - HalfCount) + 1;
            BeforePageCount = Page - 1;
        }          
        if  (PrivPage<1) PrivPage = 1;
        if  (NextPage>TotalPageCount) NextPage = Page;
                                  
        var Pages = [];
        for (var i = Page - BeforePageCount; i < Page; i++) {
            Pages.push(i);
        } 
        Pages.push(Page);        
        for (var i = Page+1; i <= Page + AfterPageCount; i++) {
            Pages.push(i);
        }
        var PageButtons = Pages.map(function(p){
            if (p==Page) 
            return(
                <span className="btn-page circle page-selected">{p}</span>
            ); else
            return(
                <a className="btn-page circle" href="#" onClick={this.clickHandler} data-page={p}>{p}</a>
            );
        }.bind(this));
        
        return (
            <div className="pagenav-container">
                <a className="btn-page circle" href="#" onClick={this.clickHandler} data-page={PrivPage}>&lt;</a>
                {PageButtons}
                <a className="btn-page circle" href="#" onClick={this.clickHandler} data-page={NextPage}>&gt;</a>
            </div>
        );
    }
});

var Filters = React.createClass({
    selectArtistHandler : function(e) {
        e.preventDefault();
        this.props.updateFilter('artist', e.target.value);
    },
    selectGenreHandler : function(e) {
        e.preventDefault();
        this.props.updateFilter('genre', e.target.value);
    },
    selectYearHandler : function(e) {
        e.preventDefault();
        this.props.updateFilter('year', e.target.value);
    },
    
    render : function() {
        var artist = this.props.data.artists.map(function(p){
              return (
                  <option value={p.id}>{p.title}</option>    
              );
        });
        var genres = this.props.data.genres.map(function(p){
              return (
                  <option value={p.id}>{p.name}</option>    
              );
        });
        var years = this.props.data.years.map(function(p){
              return (
                  <option value={p.id}>{p.year}</option>    
              );
        });
    
        return(
              <div>
              <span>Исполнитель</span>
              <select size="1" className="fld-filter" onChange={this.selectArtistHandler}>
                  <option>все</option>
                  {artist}
              </select>
              <span>Жанр</span>
              <select size="1" className="fld-filter" onChange={this.selectGenreHandler}>
                  <option>все</option>
                  {genres}
              </select>
              <span>Год</span>
              <select size="1" className="fld-filter" onChange={this.selectYearHandler}>
                  <option>все</option>
                  {years}
              </select>
              </div>
        );
    }
});

var App = React.createClass({
     getInitialState: function() {
        return {
            tracks: [],
            total: '',
            limit: 10,
            page: 1,
            sort: '',
            direction: '',
            'a.id': '',
            'g.id': '',
            't.year': '' 
        };
    },
    
    getCDATA: function(){
        return $.parseJSON($("#jsn").find("content").text()); 
    },
    
    getPageCount: function(TrackCount, limit){
        return Math.ceil(TrackCount/limit); 
    },
    
    fetchTracks: function(filters){
        var query = {};
        for(var filter in this.state) {
            if (filter!='tracks' && filter!='total') {
                query[filter] = this.state[filter];
            }    
        }
        for(var filter in filters) {
            query[filter] = filters[filter];
        }
        var i = 0;
        var queryStr = '';
        for(var filter in query) {
            if (query[filter].toString().length > 0) {
                i++;
                if (i>1) {queryStr = queryStr + '&';}
                queryStr = queryStr + filter + '=' + query[filter];
            }
        }
        var url = '/tracks?' + queryStr;
        
        $.getJSON(url, function(result){ 
            if (result.data!=null){  
                var tracks = result.data.map(function(p){
                    return { 
                        artist: p.artist, 
                        track: p.track, 
                        genre: p.genre, 
                        year: p.year
                    };
                }); 
            } else var tracks = [];           
            var total = result.total;
            this.setState({tracks: tracks, total: total});
        }.bind(this)); 
    },
    
    updateLimit: function(limit){
        var filters = {limit: limit, page: 1};
        this.setState(filters);
        this.fetchTracks(filters);
    },
    
    updateSorting: function(field, direction){
        var filters = {sort: field, direction: direction};
        this.setState(filters);
        this.fetchTracks(filters);
    },
    
    updatePage: function(page){
        var filters = {page: page}; 
        this.setState(filters);
        this.fetchTracks(filters);
    },
    
    updateFilter: function(field, value) {
        if (value == 'все') value='';
        var filters = {page: 1};
        filters[field] = value;
        this.setState(filters);
        this.fetchTracks(filters);
    },    
    
    componentDidMount: function(){
        var filters={};
        this.fetchTracks(filters);
    },
    
    render : function(){
        var cdata = this.getCDATA();
        
        return(
            <div>
            <div className="pl-container"><b>Плейлист</b>
                <TrackList tracks={this.state.tracks} updateSorting={this.updateSorting} sort={this.state.sort} direction={this.state.direction} />
                <div className="under_table-navigation">
                  <PageNav page={this.state.page} pcount={this.getPageCount(this.state.total, this.state.limit)} updatePage={this.updatePage} />
                  <LimitsNav limit={this.state.limit} updateLimit={this.updateLimit} />
                </div>
            </div>
            <div className="filter-container"><b>Фильтр</b> 
                <div className="filters-area"><Filters data={cdata} updateFilter={this.updateFilter} /></div>
            </div>   
            </div>
        );
    }
});

ReactDOM.render(
    <App />,
    document.getElementById("app")
);