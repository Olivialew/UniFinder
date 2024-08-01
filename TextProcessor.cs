using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Microsoft.ML;
using Microsoft.ML.Data;

namespace UniFinder
{
    public class TextProcessor
    {
        private static MLContext mlContext = new MLContext();

        public static float[] ComputeTfIdf(string[] documents)
        {
            var data = documents.Select(doc => new Document { Text = doc }).ToArray();
            var textData = mlContext.Data.LoadFromEnumerable(data);
            var tfidfEstimator = mlContext.Transforms.Text.FeaturizeText("Features", nameof(Document.Text));
            var textTransformer = tfidfEstimator.Fit(textData);
            var transformedData = textTransformer.Transform(textData);

            var features = transformedData.GetColumn<float[]>("Features").First();
            return features;
        }

        public static float ComputeCosineSimilarity(float[] vec1, float[] vec2)
        {
            float dotProduct = vec1.Zip(vec2, (a, b) => a * b).Sum();
            float normA = MathF.Sqrt(vec1.Sum(a => a * a));
            float normB = MathF.Sqrt(vec2.Sum(b => b * b));
            return dotProduct / (normA * normB);
        }

        public class Document
        {
            public string Text { get; set; }
        }
    }
}