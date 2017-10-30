using BRKGA, TSP, Base.Test

srand(12345) # For reproducibility
@testset "TSP" begin
    pairs = readTSP("a280.tsp")
    @testset "read instance" begin


        @test sum(pairs) == [39358, 24892]
        @test pairs[1] == [288, 149]
        @test pairs[end] == [280, 133]
        @test sum(pairs) == [39358, 24892]
    end
    para = Parameters(
            0.70, # probability that offspring inherit an allele from elite parent
            256,  # size of population
            1000, # number of generations
            0.1, # fraction of population to be the elite-set
            0.1, # fraction of population to be replaced by mutants
            1   # Crossover type
            )

    tsp = TSPProblem(pairs, para)

    @testset "decoder" begin
        obj = BRKGA.decoder(tsp, [0.62724,0.27957,0.9319,0.154122,0.16129,0.157706,0.623656,0.562724,0.616487,0.55914,0.555556,0.928315,0.0215054,0.924731,0.566308,0.53405,0.724014,0.802867,0.892473,0.899642,0.799283,0.0286738,0.0322581,0.0250896,0.863799,0.612903,0.83871,0.0681004,0.0645161,0.831541,0.415771,0.795699,0.874552,0.867384,0.827957,0.870968,0.97491,0.971326,0.792115,0.11828,0.967742,0.985663,0.78853,0.0860215,0.111111,0.207885,0.0824373,0.114695,0.982079,0.978495,0.0896057,0.078853,0.0716846,0.0752688,0.670251,0.204301,0.218638,0.21147,0.09319,0.0143369,0.222222,0.824373,0.046595,0.0107527,0.197133,0.673835,0.00716846,0.215054,0.964158,0.960573,0.200717,0.107527,0.00358423,0.666667,0.505376,0.0,0.749104,0.598566,1.0,0.523297,0.103943,0.752688,0.426523,0.602151,0.408602,0.677419,0.508961,0.494624,0.0967742,0.74552,0.516129,0.318996,0.498208,0.519713,0.501792,0.591398,0.594982,0.430108,0.512545,0.401434,0.315412,0.491039,0.996416,0.100358,0.437276,0.322581,0.0537634,0.663082,0.193548,0.913978,0.756272,0.992832,0.0501792,0.989247,0.526882,0.910394,0.605735,0.956989,0.0573477,0.903226,0.444444,0.609319,0.121864,0.412186,0.784946,0.878136,0.0179211,0.835125,0.896057,0.88172,0.0358423,0.842294,0.888889,0.845878,0.530466,0.860215,0.551971,0.921147,0.458781,0.688172,0.731183,0.713262,0.777778,0.293907,0.329749,0.810036,0.455197,0.548387,0.480287,0.65233,0.125448,0.781362,0.448029,0.0609319,0.419355,0.953405,0.422939,0.90681,0.301075,0.44086,0.326165,0.917563,0.681004,0.308244,0.487455,0.394265,0.587814,0.397849,0.433692,0.405018,0.659498,0.387097,0.311828,0.225806,0.0430108,0.0394265,0.820789,0.189964,0.304659,0.451613,0.483871,0.297491,0.655914,0.584229,0.379928,0.759857,0.390681,0.383513,0.741935,0.763441,0.817204,0.81362,0.37276,0.767025,0.18638,0.369176,0.738351,0.684588,0.709677,0.376344,0.706093,0.734767,0.365591,0.580645,0.362007,0.774194,0.648746,0.645161,0.243728,0.132616,0.695341,0.175627,0.179211,0.344086,0.182796,0.770609,0.333333,0.25448,0.290323,0.702509,0.698925,0.336918,0.340502,0.261649,0.258065,0.268817,0.247312,0.265233,0.272401,0.34767,0.637993,0.641577,0.283154,0.136201,0.286738,0.139785,0.351254,0.146953,0.150538,0.634409,0.143369,0.354839,0.275986,0.935484,0.939068,0.856631,0.473118,0.358423,0.853047,0.942652,0.250896,0.476703,0.946237,0.577061,0.229391,0.691756,0.541219,0.240143,0.232975,0.168459,0.236559,0.716846,0.172043,0.849462,0.129032,0.544803,0.806452,0.727599,0.949821,0.885305,0.72043,0.569892,0.462366,0.620072,0.573477,0.164875,0.537634,0.469534,0.46595,0.630824])
        @test obj == 10980

    end

    @testset "start GA" begin
        bestcost, gen, totaltime, bestsoltime = BRKGA.start(tsp)
        @test isapprox(bestcost, 10030.)
        @test gen == 1000
        @test isapprox(totaltime, bestsoltime; atol=1e-1)

        para.maxgen = 10000
        bestcost, gen, totaltime, bestsoltime = BRKGA.start(tsp; targetcost=10069.)
        @test isapprox(bestcost, 10047.0)

        bestcost, gen, totaltime, bestsoltime = BRKGA.start(tsp; maxstableit=50)
        @test isapprox(bestcost, 8433.)
        @test gen == 2495
    end
end
