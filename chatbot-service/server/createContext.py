from langchain_google_genai import GoogleGenerativeAI
from langchain_google_genai import GoogleGenerativeAIEmbeddings
from dotenv import load_dotenv
import os

load_dotenv()
llm = GoogleGenerativeAI(
    model="gemini-pro", google_api_key=os.environ["GOOGLE_API_KEY"]
)
print("Load LLM model Successfully --------------------- ")

google_embeddings = GoogleGenerativeAIEmbeddings(
    model="models/embedding-001", google_api_key=os.environ["GOOGLE_API_KEY"]
)
print("Load Embedding model Successfully --------------------- ")
