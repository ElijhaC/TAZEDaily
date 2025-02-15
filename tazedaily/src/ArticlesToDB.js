import { useState, Button, useEffect } from 'react';
import axios from 'axios';

const REACT_APP_ARTICLESEARCH_API_KEY = '';
/** Load Database with NY Times API */
const ArticlesToDB = () => {
    // const genreArray = ['home', 'business', 'food', 'health', 'politics', 'sports', 'style', 'technology', 'travel'];
    const [articles, setArticles] = useState([]);
    var tempArray = []

  // for (let i=0; i<1; i++) {
    // pull articles from NY Times
    const getArticles = async () => {
        const res = await axios.get(`https://api.nytimes.com/svc/search/v2/articlesearch.json?q=home&api-key=${REACT_APP_ARTICLESEARCH_API_KEY}`);
        setArticles(res.data.response.docs.splice(0, 10));
    }
    useEffect(() => {
        getArticles();
    }, [])



    tempArray = [articles.map((article) => 
        "{title: " + article.title +
        ",author: " + article.byline +
        ",snip: " + article.abstract +
        ",article: " + article.abstract +
        ",image : https://www.nytimes.com/" + article.multimedia[0].url +
        ",source : " + article.url +
        ",genre: " + article.section +
        ",date" + article.published_date + "}"
    )]
    

    const postArticles = async () => {
        try {
            const res = await axios.post('http://127.0.0.1:8080/newsarticle/postall', {tempArray})
            console.log(res.data)
        } catch (error) {
            console.log(error)
        }
    }
    useEffect(() => {
        postArticles();
    })
    return(
        <div>
            <Button>Is this on?</Button>
        </div>
    )
}


export default ArticlesToDB;