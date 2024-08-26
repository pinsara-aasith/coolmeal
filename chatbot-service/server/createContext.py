from langchain_google_genai import GoogleGenerativeAI
from langchain_google_genai import GoogleGenerativeAIEmbeddings
from dotenv import load_dotenv
from langchain_community.document_loaders import PyPDFDirectoryLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_community.vectorstores import FAISS
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

# get pdf data from directory ---------------
pdf_directory = "../food_data/pdf"
vectordb_file_path = "faiss_index"


def createVectorDB():
    # Get all file names in the directory
    pdf_file_names = os.listdir(pdf_directory)

    # Load PDF Loader in Langchain with support also for images
    pdf_loader = PyPDFDirectoryLoader(pdf_directory, extract_images=True)

    # Load all the documents in the directory
    pdf_docs = pdf_loader.load_and_split()

    # Split the documents into chunks
    text_splitter = RecursiveCharacterTextSplitter(
        chunk_size=1000, chunk_overlap=200
    )  ## Chunk Creation

    final_pdf_documents = text_splitter.split_documents(pdf_docs)

    # Create Faiss Vector database------------
    vector_db = FAISS.from_documents(pdf_docs, google_embeddings)
    # Save vector database locally
    vector_db.save_local(vectordb_file_path)

    return vector_db
